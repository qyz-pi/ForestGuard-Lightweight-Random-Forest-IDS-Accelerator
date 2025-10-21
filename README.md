To be updated

# End-to-End Random Forest Hardware Deployment

This project implements a complete workflow from Random Forest training to Vivado-ready BRAM initialization generation, referred to notebook  [`src/RF_End2End_BRAM_Export.ipynb`](./src/RF_End2End_BRAM_Export.ipynb), including:

1. Environment setup and imports  
2. Dataset loading and basic statistics  
3. Hyperparameter tuning (`n_estimators`, `max_depth`)  
4. Model training and evaluation  
5. Quantization utilities (threshold, feature, child nodes, class encoders)  
6. Exporting `random-forest.txt` (each tree separated by `x`)  
7. Generating `.coe` and `rf_bases.vh` (removing `x`, computing tree base addresses)

> **Update:** All Verilog hardware design sources have been moved under [`src/`](./src/),  
> containing RTL modules, testbench ready for Vivado integration.