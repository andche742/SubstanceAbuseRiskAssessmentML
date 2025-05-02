#! /bin/bash

input_file="cut.csv"
output_file="normalized.csv"
nscore=4
ss=10


awk -F"," -v first_c="$nscore" -v last_c="$ss" 'BEGIN {OFS = ","}
  NR == 1 {
    print $0;
    next;
  }

  {
    for (col=first_c; col<=last_c; col++) {
      if (NR == 2) {
        min[col] = $col;
        max[col] = $col;
      } else {
        if ($col < min[col]) {
          min[col] = $col;
        }
        if ($col > max[col]) {
          max[col] = $col;
        }
      }
    }
  all_data[NR] = $0;
  }

  END {
#    printf("nscore:" $first_c)
#    printf("ss:" $last_c)
#    for (col=$first_c; col<=$last_c; col++) {
    #  print("col:",col,", min:",min[col],", max:", max[col], "\n");
#      print("col:", $col);
#    }
    for (row in all_data) {
      split (all_data[row], columns, ",");
      for (col=first_c; col<=last_c; col++) {
        if (min[col] == max[col]) {
          columns[col] = 0;
        } else {
          columns[col] = (columns[col] - min[col]) / (max[col] - min[col]);
        }
      }
      for (col=1; col<=NF; col++) {
        if (col > 1) {
          printf(",");
        }
        printf("%s", columns[col]);
      }
      print("")
    }
  }' "$input_file" > "$output_file"
