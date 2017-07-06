## Reproducible Research Week 1: Practice Peer-graded Assignment

## Mick Sheahan July 2017

## Load data file
data <- download.file("https://d3c33hcgiwev3.cloudfront.net/_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?Expires=1499385600&Signature=Na0B3SeVGxfSMe39TCYF4RpTFk7Hnurq78zGFYFF2eZ1GasITxzOpne8d6tticKMY5JIkYpfpRWB5Vvqroc6KP2~wSQDU9aE2mZxHHSHVtpSUgrl9Wmciooy0d-sigrIHrNGQS~MKgtQmRxOv77wsI4Jls9LptUm4prjsmSBMVU_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A", destfile = "payments.csv")

payments <- read.csv("payments.csv", header = TRUE, sep = ",")

head(payments)

## Q1. What is the relationship between mean covered charges (Average.Covered.Charges) and mean total payments (Average.Total.Payments) in New York?

## Identify the data from New York
paymentsNY <- subset(payments, Provider.State == "NY")

## Initialise new plot

pdf(file = "plot1.pdf")

with(paymentsNY, plot(Average.Covered.Charges, Average.Total.Payments,
                      main = "Relationship between charges and payments in New York",
                      xlab = "Average Covered Charges ($)", 
                      ylab = "Average Total Payments ($)",
                      col = "blue",
                      pch = 16))

abline(lm(paymentsNY$Average.Total.Payments ~ paymentsNY$Average.Covered.Charges), col = "black", lwd = 1)

dev.off()


## Q2. How does the relationship between mean covered charges (Average.Covered.Charges) and mean total payments (Average.Total.Payments) 
##     vary by medical condition (DRG.Definition) and the state in which care was received (Provider.State)?

## Initialise new plot

pdf(file = "plot2.pdf")

par(mfrow = c(2,3), mar = c(8,4,4,4), oma = c(6,2,2,2), xpd = TRUE, bty = "n")         # set number of rows and columns, and margin parameters

with(subset(payments, Provider.State == "CA"),
     plot(Average.Covered.Charges/1000, Average.Total.Payments/1000, col = c("black", "red", "green", "blue", "pink", "brown"), pch = 16, main = "California", xlab = "Average Covered Charges", ylab = "Average Total Payments"))
     
with(subset(payments, Provider.State == "FL"), 
     plot(Average.Covered.Charges/1000, Average.Total.Payments/1000, col = c("black", "red", "green", "blue", "pink", "brown"), pch = 16, main = "Florida", xlab = "Average Covered Charges", ylab = "Average Total Payments"))     
     
with(subset(payments, Provider.State == "IL"),
     plot(Average.Covered.Charges/1000, Average.Total.Payments/1000, col = c("black", "red", "green", "blue", "pink", "brown"), pch = 16, main = "Illinois", xlab = "Average Covered Charges", ylab = "Average Total Payments"))  
     
with(subset(payments, Provider.State == "NY"),
     plot(Average.Covered.Charges/1000, Average.Total.Payments/1000, col = c("black", "red", "green", "blue", "pink", "brown"), pch = 16, main = "New York", xlab = "Average Covered Charges", ylab = "Average Total Payments"))  
     
with(subset(payments, Provider.State == "PA"),
     plot(Average.Covered.Charges/1000, Average.Total.Payments/1000, col = c("black", "red", "green", "blue", "pink", "brown"), pch = 16, main = "Pennsylvania", xlab = "Average Covered Charges", ylab = "Average Total Payments"))      
     
with(subset(payments, Provider.State == "TX"),
     plot(Average.Covered.Charges/1000, Average.Total.Payments/1000, col = c("black", "red", "green", "blue", "pink", "brown"), pch = 16, main = "Texas", xlab = "Average Covered Charges", ylab = "Average Total Payments"))
     

keys <- c("Simple Pneumonia & Pleurisy", "Heart Failure & Shock", "Esophagitis, Gastroent & Misc Digestive Disorders", 
          "Misc Disorders of Nutrition,Metaboliam,Fluids/Electrolytes",
          "Kidney & Urinary Tract Infections", "Septicemia or Severe Sepsis")

legend(-500, -10, legend = keys, xpd = NA, col = c("black", "red", "green", "blue", "pink", "brown"), lwd=4, title = "Diagnosis Related Groups")

mtext("Average charges versus payments by DRG and State (in thousands of $)", outer = TRUE)

dev.off()
