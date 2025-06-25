# Experiment: User Interface Engagement Testing

# Overview
This experiment will test if moving the prediction button away from the text input field affects the amount of prediction requests made by the user. 

# Changes
Compared to the base design of our frontend, the "Analyze Sentiment" button is moved downwards by some pixels. 

# Relevant Metrics
To analyze changes in user engagement, we will look at the ```active_prediction_requests``` metric for both the base version and the experimental release of the app. If this metric is higher, it is indicative of users performing more review queries.

# Hypothesis
We think that the experimental release will have a lower amount of ```active_prediction_requests``` compared to the base version. As users need to move their mouse more to query a prediction, time spent on waiting for a query result increases. We expect this to make the user experience worse and thus that users will query less predictions from the app.

# Decision Process


# Grafana Results

# Conclusion

# Limitations
As we have not released our app to the world, the data shown on grafana is mocked.