#!/bin/bash

input_file="./data/temp10.csv"
output_file="./data/processed.csv"
nscore=3
ss=9

awk -F"," -v first_c="$nscore" -v last_c="$ss" 'BEGIN {OFS = ","}
  NR == 1 {
    header = $0;
    next;
  }

  {
    row[NR] = $0;
    split($0, cols, ",");
    row_count[NR] = length(cols);  # Save NF
    for (col = first_c; col <= last_c; col++) {
      val = cols[col] + 0;
      if (!(col in min) || val < min[col]) min[col] = val;
      if (!(col in max) || val > max[col]) max[col] = val;
    }
  }

  END {
    print header;

    for (i = 2; i <= NR; i++) {
      split(row[i], cols, ",");
      for (col = first_c; col <= last_c; col++) {
        val = cols[col] + 0;
        if (min[col] == max[col]) {
          cols[col] = 0;
        } else {
          cols[col] = (val - min[col]) / (max[col] - min[col]);
        }
      }

      for (j = 1; j <= row_count[i]; j++) {
        printf("%s", cols[j]);
        if (j < row_count[i]) printf(",");
      }
      print "";
    }
  }
' "$input_file" > "$output_file"