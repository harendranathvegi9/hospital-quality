RankStateHospital <- function(state, outcome, rank="best") {
  # Reads the outcome-of-care-measures.csv file and returns a character vector
  # with the name of the hospital that matches the ranking of the 30-day
  # mortality for the specified outcome in that state. The hospital name is the
  # name provided in the Hospital.Name variable. Hospitals that do not have data
  # on a particular outcome are excluded from the set of hospitals when
  # deciding the rankings.
  #
  # Args:
  #   state: the 2-character abbreviated name of a state
  #   outcome: the mortality outcome, must be one of the following:
  #     “heart attack”, “heart failure”, or “pneumonia”.
  #   rank: the ranking of the hospital within the given state
  #     Can be an integer or "best" or "worst"
  #
  # Returns:
  #   The name of the hospital within the given state with the given rank
  #   for the given mortality rate outcome.
  #   If the number given by num is larger than the number of hospitals in that
  #   state, then the function returns NA

  source("utils.R")

  # Get our data frame of hospitals and given outcomes within the given state
  dfOutcomes <- GetOutcomes(state, outcome)

  # Get the numerical index of the hospital rank that we can use in
  # our dataframe
  hospitalRank <- TranslateRankToDataFrameIndex(dfOutcomes, rank)

  # Return hospital name in that state with the matching rank
  dfResult <- dfOutcomes[hospitalRank, ]
  kResultHospitalCol <- 1
  return(dfResult[, kResultHospitalCol])
}

# Tests
RankStateHospital("TX", "heart failure", 4)
# [1] "DETAR HOSPITAL NAVARRO"
RankStateHospital("MD", "heart attack", "worst")
# [1] "HARFORD MEMORIAL HOSPITAL"
RankStateHospital("MN", "heart attack", 5000)
# [1] NA
