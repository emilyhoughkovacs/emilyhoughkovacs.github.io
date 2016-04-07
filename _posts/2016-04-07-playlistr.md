---
layout: post
title: Playlistr
---

Today's post is very important to me, because I'll be talking about Playlistr, my application for creating playlists based off of a given artistic sound. This project is my final data science "passion project" for Metis, but hopefully just one of the first of many data science investigations throughout my career. The past three months have been some of the most challenging, rewarding and knowledge-filled of my life. But beyond that, I feel incredibly grateful to have had the opportunity to hone my data science skills in an environment surrounded by peers of extremely high caliber who are equally passionate about their projects as I was about mine.<br>

The motivation for my application, Playlistr, was based around the concept of drawing connections between songs based on the artists and collaborators who contributed to their sound. I was originally interested in exploring the influence of different hip-hop artists via the annotated text of rap lyrics using the website <a href="www.rapgenius.com">Rap Genius'</a> <a href="www.docs.genius.com">API</a>. On this website, users can collaboratively submit annotations that give a richer description of the text of songs, adding in references to other artists or songs on the site.<br>

One of the benefits of today's many streaming music platforms is that a listener can access various playlists. This is in contrast to the listening experience of a single artist on an album, which offered a more cohesive artistic sound, but may have had a less diverse set of songs. In creating Playlistr, I attempted to maintain the smooth listening quality of a cohesive artistic sound while choosing songs from multiple different artists.<br>

Although the primary artist offers a certain quality to songs that create a singular experience when listening to an album, I wanted to harness the artistic influence that a song's producers, writers, featured artists, and sampled songs had as well. Additionally, using links between songs that were referenced on Genius, I wanted to see if I could tease out connections that were previously unknown.<br>

To create a relationship between songs and artists, I scored each artist with a ranked weighting of their influence on a given song. Producers, writers, sampled artists and featured artists were weighted more highly than genius annotations, which in turn had more weight than the primary artist. These scores were then normalized to sum up to one for any given song. For instance, suppose the category of 'writers' took up 40% of the total weight of influence. If one song had two writers and another had one, each writer of the first song would score 20% on influence for that song, but the writer of the second song would be awarded 40% of the influence for that song. Artists who did not appear on a given track were simply weighted 0 for that track.<br>

Once this artist-to-song matrix was created, I had a very sparse dataset. To create recommendations of similar songs, I used non-negative matrix factorization to reduce the features to twenty components instead of the 1305 artists in my database. I then took the pairwise dot product along this twenty-feature vector for each pair of songs to determine which songs were most similar to each other.<br>

Finally, to create a playlist I would start with a song or artist given as input from the user. To choose the second song, I ordered the songs by their dot product similarity score to that song. Because I wanted some diversity in the songs that were chosen, I randomly selected the next track by using the absolute value of a normal distribution with large variance to choose the rank of the following song. This song was now used as the seed for choosing the third song in the playlist, and so on, until twenty tracks were selected.

Below you can see Playlistr in action with the song "Work" by Rihanna.

![work](/images/work_rihanna_v2.gif)

Suppose you knew the name of a track but not the primary artist. In this case, we type "Summer Sixteen" into Playlistr, and it anticipates that the artist is Drake.

![summer_sixteen](/images/summer_sixteen.gif)

Finally, if you're not sure what song to choose for a given artist, you can simply put in their name and Playlistr will choose a song for you.

![only_nicki](/images/only_nicki.gif)

That's all I have for now. Until next time!

--Em