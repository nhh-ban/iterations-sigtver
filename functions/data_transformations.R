# function transforming data from vegvesenet to a data frame
transform_metadata_to_df <-
  function(data){
    data[[1]] %>%  
      map(as_tibble) %>%  
      list_rbind() %>%  
      mutate(latestData = map_chr(latestData, 1, .default=NA_character_)) %>% 
      mutate(latestData = as_datetime(latestData)) %>% 
      unnest_wider(location) %>% 
      unnest_wider(latLon)
  }

# change date format to ISO8601 and adding offset
to_iso8601 <-
  function(date_time, offset){
    iso8601(date_time+days(offset)) %>% 
      paste0("Z")
  }

# transform volume information from json to data frame
transform_volumes <- 
  function(data){
    data[[1]][[1]] %>% 
      map(as_tibble) %>% 
      list_rbind() %>% 
      unnest_wider(edges) %>% 
      unnest_wider(node) %>% 
      unnest_wider(total) %>% 
      unnest_wider(volumeNumbers) %>%
      mutate(from = as_datetime(from)) %>% 
      select(from, volume)
  }
  


