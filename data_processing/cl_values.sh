#! /bin/bash

input_file="processed.csv"
output_file="cl_replaced.csv"
alcohol=11
vsa=28

awk -F"," -v first_c="$alcohol" -v last_c="$vsa" 'BEGIN {OFS=","} {
  for (col=first_c; col<=last_c; col++) {
    if ($col == "CL0" || $col == "CL1") {
      $col = 0;
    } else if ($col == "CL2" || $col == "CL3") {
      $col = 1;
    } else if ($col == "CL4" || $col == "CL5" || $col == "CL6") {
      $col = 2;
    }
  }
  print $0;
}' "$input_file" > "$output_file"
