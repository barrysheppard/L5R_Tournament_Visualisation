# Tournament Analysis for the L5R card game
A range of Useful R code relating to the L5R LCG.

* winrates_combined.R when provided with a tournament url, extracts win rates from thelotuspavilion.com tournament website for each faction and compliles them into a combined infographic.
![win rates](L5R_Tournament_Visualisation/examples/winrates.png "Win Rates")

* clanbarchart.R when provided with a tournament url, extracts details form thelotuspavilion.com tournament website and prepares bar plots with attendance, qualification, and qualification rates for each faction.
![attendance](https://github.com/barrysheppard/L5R/blob/master/examples/attendance.png "Attendance")

* tournament_top16_bracket.R when provided with a tournament url, extracts details form thelotuspavilion.com tournament website and creates a top 16 infographic colour coded by faction with player names all the way to the final with the ultimate winner.
![top16](https://github.com/barrysheppard/L5R/blob/master/examples/top16.png "Top 16")

* L5R_Rulings.Rmd extracts the judge rulings for every card from the https://fiveringsdb.com database and generates a pdf. This is used by judges on site at events.
 
R, ggplot2, data extraction, data cleaning, visualisation
