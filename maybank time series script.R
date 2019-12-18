#install.packages('TTR')
#install.packages('matrixStats')
#install.packages('StanHeaders')
#install.packages('extraDistr')
#install.packages('rstan')
#install.packages('prophet')
# Download RTools

maybank.raw.data = read.csv('Maybank for R.csv')
str(maybank.raw.data)

#Extract data for prophet

ds = as.Date(maybank.raw.data$DATE, format="%d/%m/%Y")
y = maybank.raw.data$DAILY.RETURN
maybank.data = data.frame(ds,y)
str(maybank.data)

library(prophet)
m <- prophet(maybank.data)
future <- make_future_dataframe(m, periods = 365)
tail(future)

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

plot(m, forecast)

prophet_plot_components(m, forecast)

dyplot.prophet(m, forecast)