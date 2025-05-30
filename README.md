# Proactive Risk Assessment of Substance Abuse Using Multi-Class Machine Learning

This project uses machine learning to proactively assess the risk of substance abuse based on demographic and psychological data. Instead of relying on reactive, self-reported screening tools, we apply supervised learning models to predict substance consumption patterns and risk levels.

## Goal 
- **Goal**: Predict risk of future drug use using personality, demographic, and behavioral data.

## Dataset
- **Source**: [UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/373/drug+consumption+quantified)  
- **Size**: 1,884 entries, 32 features  
- **Features**:
  - Demographics: age, gender, country, education, ethnicity
  - Personality traits: NEO-FFI-R, impulsiveness, sensation-seeking
  - Drug usage: 19 drugs labeled across 7 time-based use levels
    - CL0: Never used before
    - CL1: Used over a decade ago
    - CL2: Used within last decade
    - CL3: Used within last year
    - CL4: Used within last month
    - CL5: Used within last week
    - CL6: Used within last day

## Data Preprocessing
- Removed users claiming to have used the fictitious drug “Semeron”
- Encoded categorical variables (gender, education, ethnicity, etc.)
- Normalized continuous features
- Grouped drug usage into 2 risk levels:  
  - **0**: Not at risk (CL0, CL1, CL2)
  - **1**: Potentially at risk (CL3–CL6)

## Handling Imbalanced Data
- Used **SMOTENC**, **Random Oversampling (ROS)**, and **Random Undersampling (RUS)**
- Focused on **Heroin (imbalanced)** and **Cannabis (balanced)** for analysis

## Models Used
1. **Multilayer Perceptron (MLP)**  
2. **Random Forest**  
3. **Logistic Regression**

All models were tuned using `GridSearchCV` and evaluated using **macro recall** due to the importance of detecting minority (usually at-risk) classes.

## Results Summary
- **MLP** performed best overall, especially on balanced data
- **Random Forest** had tuning challenges on imbalanced data
- **Logistic Regression** served as a solid baseline
- Balancing data improved performance, particularly for Heroin

## Key Metrics (Heroin, Balanced)
- **Recall (minority class)**: Up to 74% (MLP)
- **Precision (minority class)**: Low, but acceptable given goal of minimizing false negatives

## Conclusion
This project demonstrates that machine learning models can support early identification of individuals at risk for substance abuse, with promising recall rates that could complement traditional screening methods in the healthcare system.

## References
- [UCI Drug Use Dataset](https://archive.ics.uci.edu/dataset/373/drug+consumption+quantified)  
- [National Institute on Drug Abuse](https://nida.nih.gov/)  
- Jing et al., 2020: Childhood evaluation of liability to substance use disorder
