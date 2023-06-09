## setup
dir = "~/Documents/learn/visuals-R/" # change it to correct dir
pacman::p_load(ggplot2, dplyr, stringr)

## load data
hike_data <- readr::read_rds('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-24/hike_data.rds')

## preprocessing
hike_data$region <- as.factor(stringr::word(hike_data$location, 1, 
                                   sep = " -- ")) # extract the region from location
hike_data$length_num <- as.numeric(sapply(strsplit(hike_data$length, " "), 
                                          "[[", 1)) # extract the number of miles

plot_df <- hike_data %>%
  group_by(region) %>%
  summarise(
    sum_length = sum(length_num),
    mean_gain = mean(as.numeric(gain)),
    n = n()
  ) %>%
  mutate(mean_gain = round(mean_gain, digits = 0)) 

# compute the cumulative length and mean gain for each region, 
# as well as recording the number of tracks per region. 

# plot: base plot
plt <- ggplot(plot_df) +
  # Make custom panel grid
  geom_hline(
    aes(yintercept = y), 
    data.frame(y = c(0:3) * 1000),
    color = "lightgrey"
  ) + 
  # Add bars to represent the cumulative track lengths
  # str_wrap(region, 5) wraps the text so each line has at most 5 characters
  # (but it doesn't break long words!)
  geom_col(
    aes(
      x = reorder(str_wrap(region, 5), sum_length),
      y = sum_length,
      fill = n
    ),
    position = "dodge2",
    show.legend = TRUE,
    alpha = .9
  ) +
  
  # Add dots to represent the mean gain
  geom_point(
    aes(
      x = reorder(str_wrap(region, 5),sum_length),
      y = mean_gain
    ),
    size = 3,
    color = "gray12"
  ) +
  
  # Lollipop shaft for mean gain per region
  geom_segment(
    aes(
      x = reorder(str_wrap(region, 5), sum_length),
      y = 0,
      xend = reorder(str_wrap(region, 5), sum_length),
      yend = 3000
    ),
    linetype = "dashed",
    color = "gray12"
  ) + 
  
  # Make it circular!
  coord_polar()

# plot: add annotation and legend
plt <- plt +
  # Annotate the bars and the lollipops so the reader understands the scaling
  annotate(
    x = 11, 
    y = 1300,
    label = "Mean Elevation Gain\n[FASL]",
    geom = "text",
    angle = -67.5,
    color = "gray12",
    size = 2.5,
    family = "Bell MT"
  ) +
  annotate(
    x = 11, 
    y = 3150,
    label = "Cummulative Length [FT]",
    geom = "text",
    angle = 23,
    color = "gray12",
    size = 2.5,
    family = "Bell MT"
  ) +
  # Annotate custom scale inside plot
  annotate(
    x = 11.7, 
    y = 1100, 
    label = "1000", 
    geom = "text", 
    color = "gray12", 
    family = "Bell MT"
  ) +
  annotate(
    x = 11.7, 
    y = 2100, 
    label = "2000", 
    geom = "text", 
    color = "gray12", 
    family = "Bell MT"
  ) +
  annotate(
    x = 11.7, 
    y =3100, 
    label = "3000", 
    geom = "text", 
    color = "gray12", 
    family = "Bell MT"
  ) +
  # Scale y axis so bars don't start in the center
  scale_y_continuous(
    limits = c(-1500, 3500),
    expand = c(0, 0),
    breaks = c(0, 1000, 2000, 3000)
  ) + 
  # New fill and legend title for number of tracks per region
  scale_fill_gradientn(
    "Amount of Tracks",
    colours = c( "#6C5B7B","#C06C84","#F67280","#F8B195")
  ) +
  # Make the guide for the fill discrete
  guides(
    fill = guide_colorsteps(
      barwidth = 15, barheight = .5, title.position = "top", title.hjust = .5
    )
  ) +
  theme(
    # Remove axis ticks and text
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.text.y = element_blank(),
    # Use gray text for the region names
    axis.text.x = element_text(color = "gray12", size = 12),
    # Move the legend to the bottom
    legend.position = "bottom",
  )


## plot: add text
plt <- plt + 
  # Add labels
  labs(
    title = "\nHiking Locations in Washington",
    subtitle = paste(
      "\nThis Visualisation shows the cummulative length of tracks,",
      "the amount of tracks and the mean gain in elevation per location.\n",
      "If you are an experienced hiker, you might want to go",
      "to the North Cascades since there are a lot of tracks,",
      "higher elevations and total length to overcome.",
      sep = "\n"
    ),
    caption = "\n\nData Visualisation by Tobias Stalder\ntobias-stalder.netlify.app\nSource: TidyX Crew (Ellis Hughes, Patrick Ward)\nLink to Data: github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-11-24/readme.md") +
  # Customize general theme
  theme(
    
    # Set default color and font family for the text
    text = element_text(color = "gray12", family = "Bell MT"),
    
    # Customize the text in the title, subtitle, and caption
    plot.title = element_text(face = "bold", size = 25, hjust = 0.05),
    plot.subtitle = element_text(size = 14, hjust = 0.05),
    plot.caption = element_text(size = 10, hjust = .5),
    
    # Make the background white and remove extra grid lines
    panel.background = element_rect(fill = "white", color = "white"),
    panel.grid = element_blank(),
    panel.grid.major.x = element_blank()
  )

## save it
ggsave("C:/Users/tuooo/OneDrive/Desktop/visual-R/40.radar/radar.png", 
       plt,width=9, height=12.6)
