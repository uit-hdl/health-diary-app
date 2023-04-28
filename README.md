The scripts in this repository requires data from the Tromsø surveys 4-7 in long format (vertically stacked).

To run the scripts that generates the analysis, navigate to `setup` and run `runMeAtStartup.m`, which adds folders essential folders to path, and loads the data and processes the data and stores it in a workspace variable called `data`. The expected folder structure is as follows


├───data  
│   ├───diary data  
│   └───fitbit data  
├───saved matlab files  
│   ├───app config  
│   ├───models  
│   ├───saved variables  
│   ├───tables  
│   └───user-tables  
├───src  
│   ├───¤¤ article  
│   └───setup  

The ``data`` folder is expected to contain the data: ``hscl_long.csv`` and 
``hscl_wide.csv`` (the latter is not nessecary for the main analysis). The matlab app can be found in `src/prototype/secondPrototype.mlapp`. Before running the app, the script `src/¤¤ article/model_regression.mat` must be run, which fits and dumps the linear model into the `saved matlab files/models` folder. 

To produce a result in the article, navigate to the `src/¤¤ article` folder, and run the corresponding script contained in that folder.