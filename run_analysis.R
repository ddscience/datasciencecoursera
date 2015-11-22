
loadfile<-function(fstring) {
        df<-read.table(fstring)
        df
}

getfeatures<-function() {
        featuresdf<-loadfile("features.txt")
        
        myfeatures<-featuresdf[grep("mean|std", featuresdf$V2),]
        myfeatures<-transform(myfeatures, V2=as.character(V2))
        myfeatures
}

labelactivity<-function(df) {
        df$activity[df$activity==1] <- "1 WALKING"
        df$activity[df$activity==2] <- "2 WALKING_UPSTAIRS"
        df$activity[df$activity==3] <- "3 WALKING_DOWNSTAIRS"
        df$activity[df$activity==4] <- "4 SITTING"
        df$activity[df$activity==5] <- "5 STANDING"
        df$activity[df$activity==6] <- "6 LAYING"
        df
}

mergedata<-function(vecfeatures) {
        xtest<-loadfile("test/x_test.txt")
        ytest<-loadfile("test/y_test.txt")
        xtrain<-loadfile("train/x_train.txt")
        ytrain<-loadfile("train/y_train.txt")
        testsub<-loadfile("test/subject_test.txt")
        trainsub<-loadfile("train/subject_train.txt")
        
        #filter the dataframes for the features
        testdf<-xtest[,vecfeatures]
        traindf<-xtrain[,vecfeatures]
        
        #add additional columns for activity, subject
        testdf<-cbind(activity=ytest$V1, testdf)
        testdf<-cbind(subject=testsub$V1, testdf)
        
        traindf<-cbind(activity=ytrain$V1, traindf)
        traindf<-cbind(subject=trainsub$V1, traindf)
        
        #merge dataframes
        data<-rbind(traindf, testdf)
        data

}




#select for only the std/means and get descriptive names
myfeatures<-getfeatures()
vecfeatures<-as.numeric(myfeatures$V1)
featurelabels<-myfeatures$V2

#fetch, select features, and combine data
data<-mergedata(vecfeatures)


#for the activity replace number with descriptive name of activity
data<-labelactivity(data)

#labels the dataset with the appropriate variable/column names
featurelabels<-c("subject", "activity", featurelabels)
names(data)<-featurelabels


#intialize a formatted dataframe for final output

output<-as.data.frame(data[0,], stringsAsFactors=F)

#aggregate function and order the dataframe by subject and activity
#aggregate calculates the means by the factors: subject and activity
output<-aggregate(. ~ subject + activity, data=data, FUN="mean")
output<-output[order(output$subject, output$activity), ]

write.table(output, file="tidy.txt", row.names = F)

