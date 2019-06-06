#!/usr/bin/perl
# Copyright 2019 National Research Council Canada, Construction Research Centre
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this 
# software and associated documentation files (the "Software"), to deal in the Software 
# without restriction, including without limitation the rights to use, copy, modify, 
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
# permit persons to whom the Software is furnished to do so, subject to the following 
# conditions:
#
#   The above copyright notice and this permission notice shall be included in all 
#   copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# --------------------------------------------------------------------
# Declare modules which are used
# --------------------------------------------------------------------
# CPAN Modules
use warnings;
use strict;
use XML::Simple; # to parse the XML results files
use Data::Dumper;

# INPUTS
my $sInputFile="Tables.xml"; # Path and filename of input
my $fLow = 10.0;
my $fHigh = 9999.0;

# INTERMEDIATES
my @sClimates = qw(CZ_4 CZ_5 CZ_6 CZ_7A CZ_7B CZ_8);
my @sHouseTypes = qw(SingleDetached DoubleRow );
my @Para; # Array of strings to hold parameters to vary
my $ParaHash;  # HASH to hold parameters

# OUTPUTS
my $sOccFile = "_Combos.txt";
my $sFinalCombos = "_Combos_Processed.csv";

# Parse the input
my $hInput = XMLin($sInputFile, ForceArray => [ 'items' ]);
foreach my $sOption (keys %{$hInput}) {
    push(@Para, $sOption);
};

# --------------------------------------------------------------------
# Determine all possible combinations of packages
# --------------------------------------------------------------------
foreach my $sType (@sHouseTypes) {
    foreach my $sClimate (@sClimates) {
        my @list;
        my $j=0;
        foreach my $sOption (@Para) {
            my $hRef;
            my $k=0;

            # Airtightness is indexed slightly differently
            if($sOption =~ /^Airtightness$/) {
                $hRef = $hInput->{"$sOption"}->{"$sType"}->{'items'};
            } else {
                $hRef = $hInput->{"$sOption"}->{'items'};
            };

            foreach my $hEntry (@{$hRef}) {
                if(exists $hEntry->{"$sClimate"}) {
                    $list[$j][$k]=$hEntry->{'description'};
                    $k++;
                };
            };
            $j++;
        }; # END OPTIONS LOOP
        # All options for this climate zone and gathered. Generate all combos
        my $sThisOut = $sType."_".$sClimate.$sOccFile;
        open my $fh, '>', $sThisOut or die "Cannot open $sThisOut: $!";
        my @dummy = ();
        print $fh "@Para\n";
        AllCombos(\@list,0,\@dummy,$fh);
        close $fh;
    }; # END CLIMATE LOOP
}; # END HOUSE TYPE LOOP

# --------------------------------------------------------------------
# Calculate total points of all packages
# --------------------------------------------------------------------
foreach my $sType (@sHouseTypes) {
    foreach my $sClimate (@sClimates) {
        my $sThisIn = $sType."_".$sClimate.$sOccFile;
        open my $fid, '<', $sThisIn or die "Cannot open $sThisIn: $!";
        my @sAllData = <$fid>;
        close $fid;
        shift @sAllData; # Remove header
        # Open new csv file
        my $sThisOut = $sType."_".$sClimate.$sFinalCombos;
        open my $foo, '>', $sThisOut or die "Cannot open $sThisOut: $!";
        foreach my $sHead (@Para) {print $foo "$sHead,";}
        print $foo "Total_Points\n";
        foreach my $sData (@sAllData) {
            chomp $sData;
            my @sLineData = split /\s/, $sData;
            my $fThesePoints=0;
            for(my $i=0;$i<=$#Para;$i++) {
                my $sOption = $Para[$i];
                my $sItem = $sLineData[$i];
                my $hRef;
                # Airtightness is indexed slightly differently
                if($sOption =~ /^Airtightness$/) {
                    $hRef = $hInput->{"$sOption"}->{"$sType"}->{'items'};
                } else {
                    $hRef = $hInput->{"$sOption"}->{'items'};
                };
                foreach my $hEntry (@{$hRef}) {
                    if($hEntry->{'description'} =~ m/^$sItem/) {
                        $fThesePoints+= $hEntry->{"$sClimate"};
                        last;
                    };
                };
            };
            if($fThesePoints>=$fLow && $fThesePoints<=$fHigh) {
                foreach my $sOpts (@sLineData) {print $foo "$sOpts,";}
                print $foo "$fThesePoints\n";
            };
        };
        close $foo;
    };
};


# -----------------------------------------------
# Subroutines
# -----------------------------------------------
SUBROUTINES: {
    sub AllCombos { # Recursive method to determine all permutations of 
                    # parameter combinations
        # Read in inputs
        my ($l_ref, $level, $cur_ref, $fh) = @_;
        my @list = @$l_ref;
        my @current = @$cur_ref;
        # Local variable
        my $size = scalar(@list);
        
        if ($level == $size) { # Reached top level
            print $fh "@current\n";
        } else {
            my $t_ref = $list[$level];
            my @temp = @$t_ref;
            foreach my $s (@temp) {
                $current[$level]=$s;
                AllCombos(\@list,($level+1),\@current,$fh);
            };
        };
		return (0);
	};
};