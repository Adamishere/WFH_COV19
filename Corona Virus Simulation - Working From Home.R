#Corona Virus Simulations
#This simulation analyzes the time a person would be in the office before they realize they are sick

#Time from infection to incubation period is modeled
# as log normal distribution
#https://annals.org/aim/fullarticle/2762808/incubation-period-coronavirus-disease-2019-covid-19-from-publicly-reported

#work schedule
day<-c(1,2,3,4,5,6,7)
ooo<-c(0,1,0,1,0,1,0)
schedule<-cbind(rep(day,10),rep(ooo,10))

#Work from home Simulation
# schedule - dataframe - A work schedule, 1 = in the office, 0 = work from home/weekend
# verbose - boolean - suppresses simulation output (default False)

wfh_simulation<-function(schedule,verbose=F){
  #Track Simulation data
  trackdays<-NULL
  
  #Simulate time til symptomatic, random infection date, time in office
  for(t in 1:15000){
    #incubation period
    incu_pd<-round(rlnorm(1, 
           meanlog = 1.621, 
           sdlog = 0.418))
      #plot(density(prob_incu))
    
    #date of infection
    dxdt<-sample(1:7,1)
    x<-0
    cur_dt<-dxdt
    daysinwork<-0
    
    for(i in 1:incu_pd){
      daysinwork<-schedule[cur_dt,2]+daysinwork
      if(verbose == T){
        print(paste("Day of week",schedule[cur_dt,1],
                    ", workday?:",schedule[cur_dt,2]))
      }
      #Count next day
      cur_dt<-cur_dt+1
    }
    #store simulation
    trackdays<-c(trackdays,daysinwork)
  }
  return(trackdays)
}



day<-c(1,2,3,4,5,6,7)

#work schedule1
ooo<-c(0,1,1,1,1,1,0)
s0111110<-cbind(rep(day,10),rep(ooo,10))

#work schedule2
ooo<-c(0,0,1,1,1,1,0)
s0011110<-cbind(rep(day,10),rep(ooo,10))

#work schedule3
ooo<-c(0,1,0,1,1,1,0)
s0101110<-cbind(rep(day,10),rep(ooo,10))

#work schedule4
ooo<-c(0,1,1,0,1,1,0)
s0110110<-cbind(rep(day,10),rep(ooo,10))

#work schedule5
ooo<-c(0,1,1,1,0,1,0)
s0111010<-cbind(rep(day,10),rep(ooo,10))

#work schedule6
ooo<-c(0,1,1,1,1,0,0)
s0111100<-cbind(rep(day,10),rep(ooo,10))

#additional days
ooo<-c(0,1,1,1,0,0,0)
s0111000<-cbind(rep(day,10),rep(ooo,10))
ooo<-c(0,1,1,0,0,0,0)
s0110000<-cbind(rep(day,10),rep(ooo,10))

#testing order of the day.
dat_s0111110<-(wfh_simulation(s0111110))
dat_s0011110<-(wfh_simulation(s0011110))
dat_s0101110<-(wfh_simulation(s0101110))
dat_s0110110<-(wfh_simulation(s0110110))
dat_s0111010<-(wfh_simulation(s0111010))
dat_s0111100<-(wfh_simulation(s0111100))

#testing additional days out of the office
dat_s0111000<-(wfh_simulation(s0111000))
dat_s0110000<-(wfh_simulation(s0110000))

#Summary Statistics
summary((dat_s0111110))
summary((dat_s0011110))
summary((dat_s0101110))
summary((dat_s0110110))
summary((dat_s0111010))

sd(dat_s0111110)
sd(dat_s0011110)
sd(dat_s0101110)
sd(dat_s0110110)
sd(dat_s0111010)

#Summary statistics - Less time in the office
summary((dat_s0111110))
summary((dat_s0111100))
summary((dat_s0111000))
summary((dat_s0110000))

#Significance testing;
#Create dataset
simdat<-as.data.frame(
  rbind(
  cbind(1,dat_s0111110),
  cbind(2,dat_s0011110),
  cbind(3,dat_s0101110),
  cbind(4,dat_s0110110),
  cbind(5,dat_s0111010),
  cbind(6,dat_s0111100)))
names(simdat)<-c("group","count")
simdat$group<-as.factor(simdat$group)
#ANOVA Global
summary(aov(count ~ group,simdat))

#Pairwise Post-hocs
pairwise.t.test(simdat$count, simdat$group, data=simdat, p.adj = "holm")


hist(trackdays)
summary(trackdays)
sd(trackdays)

schedule