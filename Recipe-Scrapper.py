# Scrapes recipe data from URL and stores it in JSON file
# before that downloads the images from Image URL and stores it in a directory

import os
import json
import requests
from selenium import webdriver
from selenium.webdriver.common.by import By
from recipe_scrapers import scrape_me

# Create a folder to store images if it doesn't exist
image_folder = 'Images'
if not os.path.exists(image_folder):
    os.makedirs(image_folder)

# List of URLs with recipe links
urls = [
    "https://www.allrecipes.com/recipes/17562/dinner/", 
    "https://www.allrecipes.com/recipes/94/soups-stews-and-chili/",
    "https://www.allrecipes.com/recipes/80/main-dish/", 
    "https://www.allrecipes.com/recipes/96/salad/",
    "https://www.allrecipes.com/recipes/156/bread/",
    "https://www.allrecipes.com/recipes/79/desserts/",
    "https://www.allrecipes.com/recipes/77/drinks/",
    "https://www.allrecipes.com/recipes/699/world-cuisine/asian/japanese/",
    "https://www.allrecipes.com/recipes/715/world-cuisine/european/eastern-european/polish/",
    "https://www.allrecipes.com/recipes/233/world-cuisine/asian/indian/",
    "https://www.allrecipes.com/recipes/695/world-cuisine/asian/chinese/",
    "https://www.allrecipes.com/recipes/17057/everyday-cooking/more-meal-ideas/5-ingredients/main-dishes/", 
    "https://www.allrecipes.com/recipes/15436/everyday-cooking/one-pot-meals/", 
    "https://www.allrecipes.com/recipes/1947/everyday-cooking/quick-and-easy/", 
    "https://www.allrecipes.com/recipes/455/everyday-cooking/more-meal-ideas/30-minute-meals/"
]

# Use a webdriver
driver = webdriver.Chrome()

# List to store scraped recipe data
scraped_recipes = []

# Loop through each URL
for url in urls:
    # Load the page
    driver.get(url)

    # Wait for some time to allow dynamic content to load (you may need to adjust this)
    driver.implicitly_wait(10)

    # Find recipe links on the homepage
    recipe_links = [a.get_attribute('href') for a in driver.find_elements(By.CSS_SELECTOR, 'a[href*="/recipe/"]')]

for link in recipe_links:
    # Create a scraper instance for the current recipe link
    scraper = scrape_me(link, wild_mode=True)

    # Download the image and get the local path
    image_url = scraper.image()

    # Remove invalid characters from the title
    title_cleaned = scraper.title().replace('"', '').replace(' ', '_')

    # Construct the image path
    image_name = os.path.join(image_folder, f"{title_cleaned}.jpg")

    with open(image_name, 'wb') as img_file:
        img_file.write(requests.get(image_url).content)

    # Store information for the current recipe in a dictionary
    recipe_data = {
        "title": scraper.title(),
        "image_path": image_name,
        "ingredients": scraper.ingredients(),
        "instructions": scraper.instructions(),
    }

    # Append the dictionary to the list
    scraped_recipes.append(recipe_data)

# Close the browser window
driver.quit()

# Save the scraped data to a JSON file
with open('scraped_recipes.json', 'w') as json_file:
    json.dump(scraped_recipes, json_file)

# Output success message
print("Scraped data saved to 'scraped_recipes.json'")