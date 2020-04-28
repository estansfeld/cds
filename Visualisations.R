library(ggplot2)

# Weekly cause of death 2020 per 1000 people in Scotland
ggplot(Scotland_Age_by_Week, aes(x = week_beginning, y = deaths_per_thousand,  colour=cause, group=cause)) +
  geom_line() +
  xlab("Month") +
  ggtitle("Weekly deaths per thousand in Scotland 2020") +
  facet_wrap(~age)

ggplot(Scotland_Age_by_Week, aes(x = week_beginning, y = deaths_per_thousand,  colour=age, group=age)) +
  geom_line() +
  xlab("Month") +
  ggtitle("Weekly deaths per thousand in Scotland 2020") +
  facet_wrap(~cause)

# Weekly cause of death 2020 per 1000 people in Scotland
ggplot(Scotland_Location_by_Week, aes(x = week_beginning, y = deaths_per_thousand,  colour=cause, group=cause)) +
  geom_line() +
  xlab("Month") +
  ggtitle("Weekly deaths per thousand in Scotland 2020") +
  facet_wrap(~location)

ggplot(Scotland_Location_by_Week, aes(x = week_beginning, y = deaths_per_thousand,  colour=location, group=location)) +
  geom_line() +
  xlab("Month") +
  ggtitle("Weekly deaths per thousand in Scotland 2020") +
  facet_wrap(~cause)

  # geom_vline(aes(xintercept = date), data = External_events, linetype="dashed") +
  # geom_text(data = External_events, aes(x = date, label = event), y = 0.1, angle = 90) 

# graphs by health board area by week
  ggplot(BoardsCause_by_Week, 
         aes(x = week_beginning,y = deaths_per_thousand, colour=cause, group=cause)) +
    geom_smooth() +
    xlab("Month") +
    ggtitle("Weekly deaths per thousand in Health Board Areas 2020") +
    facet_wrap(~area)

  # graphs by council by week
  ggplot(CouncilsCause_by_Week, 
         aes(x = week_beginning,y = deaths_per_thousand, colour=cause, group=cause)) +
    geom_smooth() +
    xlab("Month") +
    ggtitle("Weekly deaths per thousand in Council Areas 2020") +
    facet_wrap(~area)  
  
# graphs by age by week
  ggplot(Demographics_by_Week, 
         aes(x = week_beginning,y = deaths_per_thousand, colour=age, group=age)) +
    geom_smooth() +
    xlab("Month") +
    ggtitle("Weekly deaths per thousand per age group 2020") +
    facet_wrap(~sex)  
  