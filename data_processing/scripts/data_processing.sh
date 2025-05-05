#!/bin/zsh

sed 's/"Some college or university, no certificate or degree"/Some college/g' ./data/original_dataset.csv > ./data/temp2.csv
	# Fixing this column first since it contains comma

(head -n1 ./data/temp2.csv && tail -n +2 ./data/temp2.csv| awk -F',' '{if ($31 == "CL0") print $0}') > ./data/temp3.csv
	# Removing columns where 'Semer' column != 'CL0'

paste -d',' <(cut -d',' -f1-30 ./data/temp3.csv) <(cut -d',' -f32 ./data/temp3.csv) > ./data/remove_semer.csv
	# Removing 'Semer' column

awk -F',' '{\
  if ($2 == "18-24") $2 = 1;\
  if ($2 == "25-34") $2 = 2;\
  if ($2 == "35-44") $2 = 3;\
  if ($2 == "45-54") $2 = 4;\
  if ($2 == "55-64") $2 = 5;\
  if ($2 == "65+") $2 = 6;\
  print $0
}' OFS="," ./data/remove_semer.csv > ./data/temp6.csv
	# Ordinal encoding for age

awk -F',' '{\
  if ($4 == "Left school at 16 years") $4 = 2;\
  if ($4 == "Left school at 17 years") $4 = 3;\
  if ($4 == "Left school at 18 years") $4 = 4;\
  if ($4 == "Left school before 16 years") $4 = 1;\
  if ($4 == "Professional certificate/ diploma") $4 = 5;\
  if ($4 == "Some college") $4 = 6;\
  if ($4 == "University degree") $4 = 7;\
  if ($4 == "Masters degree") $4 = 8;\
  if ($4 == "Doctorate degree") $4 = 9;\
  print $0\
}' OFS=',' ./data/temp6.csv > ./data/temp7.csv
	# Ordinal encoding for education

chmod +x ./scripts/one_hot_country.txt
	# Allow execution of one-hot script for countries
./scripts/one_hot_country.txt

(paste -d ',' <(head -n1 ./data/one_hot_country.csv) <(echo "gender_F,gender_M") && tail -n +2 ./data/one_hot_country.csv| awk -F',' '{if ($3 == "F") print $0 ",1,0"; if ($3 == "M") print $0 ",0,1"}' OFS=",") > ./data/temp8.csv
paste -d',' <(cut -d',' -f1-2 ./data/temp8.csv) <(cut -d',' -f4-39 ./data/temp8.csv) > ./data/one_hot_gender.csv
  # One-hot encoding for gender
  
chmod +x ./scripts/one_hot_eth.txt
	# Allow execution of one-hot script for ethnicities
./scripts/one_hot_eth.txt


sed -e 's/CL0/0/g' -e 's/CL1/0/g' -e 's/CL2/0/g' -e 's/CL3/1/g' -e 's/CL4/1/g' -e 's/CL5/1/g' -e 's/CL6/1/g' ./data/one_hot_eth.csv > ./data/temp8.csv
	# Changing CL0-6 ranking to 1-3 (not at risk, potentially at risk, at risk)

cut -d',' -f2-44 ./data/temp8.csv > ./data/temp9.csv
	# Removing ID column

paste -d ',' <(cut -d ',' -f1-9 ./data/temp9.csv) <(cut -d ',' -f28-43 ./data/temp9.csv) <(cut -d ',' -f10-27 ./data/temp9.csv) > ./data/temp10.csv 
  # Rearranging targets to be at the end

chmod +x ./scripts/normalization.sh
  # Execute perm
./scripts/normalization.sh

rm ./data/temp*.csv ./data/one_hot_*.csv ./data/remove_semer.csv
  # Cleaning up