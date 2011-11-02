function [ train,test, validation, range, data ] = initDataset( name, withENN, k )

if strcmpi(name,'pima') == 1,
    
    load pima.data;
    data = dataset( pima(:,1:8) , pima(:,9) );
    
    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account.     
    
    w = scalem(data,'c-variance');
    data = data * w;       
    
    [train,test] =  gendat(data,0.5);
    [train,validation] =  gendat(train,0.75);
   
    range = max( train.data ) - min( train.data );
    
elseif strcmpi(name,'breast') == 1,
    
    load breast.data
    %breast dataset
    breast(:,1) = [];
    labels = breast(:,1);
    breast(:,2) = [];
    breast(:,1) = [];
 
    %range for distance measure
    data = dataset(breast(:,1:30),labels);
        
    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are taken
    %into account.     
    
    w = scalem(data,'c-variance');
    data = data * w;       
    
    [train,test] =  gendat(data,0.5);
    [train,validation] =  gendat(train,0.75);
   
    range = (max(train.data) - min(train.data));
  
elseif  strcmpi(name,'sonar') == 1,
  
  load Sonar.data;
  data = dataset(Sonar(:,1:60),Sonar(:,61));
  [train,test] =  gendat(data,0.5);
  [train,validation] =  gendat(train,0.75);
 
  range = (max(train.data) - min(train.data));
  
elseif  strcmpi(name,'ionosphere') == 1,
  
  load ionosphere.data;
  data = dataset(ionosphere(:,1:34),ionosphere(:,35));
  
    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account.     
    
    w = scalem(data,'c-variance');
    data = data * w;     
  
  [train,test] =  gendat(data,0.5);
  [train,validation] =  gendat(train,0.75);
  range = (max(train.data) - min(train.data));    

elseif    strcmpi(name,'segmentation') == 1,
    
    load segmentationTraining.data;
    load segmentationTest.data;
    
    train = dataset(segmentationTraining(:,2:20),segmentationTraining(:,1));
    test = dataset(segmentationTest(:,2:20),segmentationTest(:,1));
    
    
    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account.     
    w = scalem(train,'c-variance');
    train = train * w; 
    
    
    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account. 
    w = scalem(test,'c-variance');
    test = test * w; 
    
    [train,validation] =  gendat(train,0.75);
   
    range = max(train.data) - min(train.data);
    data = train;
 
elseif  strcmpi(name,'liver') == 1,
    
    load bupa.data;
    data = dataset(bupa(:,1:6),bupa(:,7));
    
    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account.     
    
    w = scalem(data,'c-variance');
    data = data * w;    
    
    [train,test] =  gendat(data,0.5);
    [train,validation] =  gendat(train,0.75);
    range = (max(train.data) - min(train.data));
    

elseif  strcmpi(name,'optdigit') == 1,
    
    load optdigitsTrain.data;
    load optdigitsTest.data;
    
    train = optdigitsTrain;
    optdigitsTrain = [];
    test = optdigitsTest; 
    optdigitsTest = [];
    
    train = dataset(train(:,1:64),train(:,65));
    test = dataset(test(:,1:64),test(:,65));
    
    
    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account.     
    w = scalem(train,'c-variance');
    train = train * w; 
    
    
    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account. 
    w = scalem(test,'c-variance');
    test = test * w; 
    
    [train,validation] =  gendat(train,0.75);
   
    range = max(train.data) - min(train.data);
    data = train;

elseif  strcmpi(name,'wine') == 1,   
    
    load wine.data;
    data = wine(:,2:14);
    labels = wine(:,1);
    
    data = dataset(data,labels);

    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account.     
    
    w = scalem(data,'c-variance');
    data = data * w;
     
    [train,test] =  gendat(data,0.5);
    [train,validation] =  gendat(train,0.75);
    
    range = max(train.data) - min(train.data);

   
  elseif  strcmpi(name,'satimage') == 1, 
      
    load training.trn;
    load testing.data;

    train = dataset(training(:,2:20),training(:,1));
    test = dataset(testing(:,2:20),testing(:,1));

    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account.     
    
    w = scalem(train,'c-variance');
    train = train * w;

    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account.     
    
    w = scalem(test,'c-variance');
    test = test * w;
    
    [train,validation] =  gendat(train,0.75);
    
    data = train;
    range = max(train.data) - min(train.data);
    
    
elseif strcmpi(name,'gaussian2') == 1, 
    
   data = gauss([200 200],[0,0 ; 3.5,0]);
   
   w = scalem(data,'c-variance');
   data = data * w;
   
   [train,test] =  gendat(data,0.50);
   [train,validation] =  gendat(train,0.75);
   
    range = max( train.data ) - min( train.data );

elseif strcmpi(name,'gaussian3') == 1, 
    
   data = gauss([300 300 300],[0,0 ; 3.5,0; 2,3.5]);
   
   w = scalem(data,'c-variance');
   data = data * w;
   
   [train,test] =  gendat(data,0.50);
   [train,validation] =  gendat(train,0.75);
   
   range = max( train.data ) - min( train.data );
    
   
elseif strcmpi(name,'banana') == 1, 
    
   data = gendatb([500 500]);
   
   w = scalem(data,'c-variance');
   data = data * w;
   
   [train,test] =  gendat(data,0.50);
   [train,validation] =  gendat(train,0.75);
   
   range = max( train.data ) - min( train.data );
   
elseif strcmpi(name,'vehicle') == 1, 
    
    load xaa.dat;
    load xab.dat;
    load xac.dat;
    load xad.dat;
    load xae.dat;
    load xaf.dat;
    load xag.dat;
    load xah.dat;
    load xai.dat;
    
    vehicle = [xaa ; xab ; xac ; xad ; xae ; xaf ; xag ; xah ; xai];
    
    data = vehicle(:,1:18);
    labels = vehicle(:,19);
    
    data = dataset(data,labels);

    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account.     
    
    w = scalem(data,'c-variance');
    data = data * w;
     
    [train,test] =  gendat(data,0.5);
    [train,validation] =  gendat(train,0.75);
    
    range = max(train.data) - min(train.data);
    
elseif strcmpi(name,'lithuanian') == 1, 

   data = gendatl([300 300 ]);
   
    w = scalem(data,'c-variance');
    data = data * w;
   
   [train,test] =  gendat(data,0.50);
   [train,validation] =  gendat(train,0.75);
   
   range = max( train.data ) - min( train.data );
   
elseif  strcmpi(name,'blood') == 1,   
    
    load transfusion.data;
    data = transfusion(:,1:4);
    labels = transfusion(:,5);
    
    data = dataset(data,labels);

    %The mean of A  is shifted to the origin and the average class 
    %variances (within-scatter) are normalized.  Class priors are 
    %taken into account.     
    
    w = scalem(data,'c-variance');
    data = data * w;
     
    [train,test] =  gendat(data,0.5);
    [train,validation] =  gendat(train,0.75);
    
    range = max(train.data) - min(train.data);
    
end;

if withENN,
    train = enn( train, k );
    validation = enn( validation, k );
end;
