---
geometry: "left=0.5in,right=0.5in,top=0.4in,bottom=0.4in"
fontsize: 10pt
colorlinks: true
linkcolor: black
urlcolor: linkblue
header-includes:
  - \definecolor{linkblue}{HTML}{1A56B8}
  - \pagestyle{empty}
  - \setlength{\parindent}{0pt}
  - \setlength{\parskip}{1pt}
  - \renewcommand{\baselinestretch}{1.0}
  - \usepackage{etoolbox}
  - \makeatletter
  - \patchcmd{\section}{\Large}{\normalsize\bfseries\MakeUppercase}{}{}
  - \patchcmd{\@startsection}{3.5ex \@plus -1ex \@minus -.2ex}{0.6ex \@plus -.2ex}{}{}
  - \patchcmd{\@startsection}{2.3ex \@plus.2ex}{0.1ex}{}{}
  - \makeatother
  - \def\tightlist{\setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}\setlength{\topsep}{0pt}}
---

\begin{center}
{\Large \textbf{Emily Hough-Kovacs}} \\[1pt]
+1 (603) 484-2534 \ \textbar\ San Francisco, CA \ \textbar\ emilyhoughkovacs@gmail.com \\
linkedin.com/in/emilyhoughkovacs \ \textbar\ www.emilyhk.com \ \textbar\ github.com/emilyhoughkovacs
\end{center}

## Summary

Senior data scientist with 10+ years at Reddit, Meta, and Spotify, now transitioning full-time into AI safety. Track record of building from zero: Spotify's creator-side metrics suite, adopted as source of truth across teams, and the measurement foundation for Reddit's ads attribution domain, which had none. Turns ambiguous problems into measurable ones, partners across product, engineering, and business, and has hosted AI safety community events in San Francisco.

## AI Safety

**Nightingale** --- work trial: triaged follow-up report from the collusion.wiki agent swarm investigation. \hfill Sep -- Oct 2026 \
**[Mercial Research Fellowship](https://mercial.uk/fellowship)** --- writing with three co-authors on the current state of AI safety. \hfill Oct -- Nov 2026 \
**[BlueDot Technical AI Safety Course](https://bluedot.org/courses/technical-ai-safety)** --- six-day intensive introduction to technical AI safety \& alignment. \hfill Oct 2026 \
**Community Building** --- co-hosted an AI Research Circle session on Constitutional AI. \hfill Mar 2026 \
\phantom{\textbf{Community Building} --- }hosted a screening and discussion of *The Thinking Game*. \hfill Jan 2026

## Projects

**[research-watcher](https://github.com/emilyhoughkovacs/research-watcher)** --- daily LLM pipeline (Python, Claude API, GitHub Actions) that ranks and summarizes new AI papers. \
**[Agentic Customer Behavior Simulator](https://github.com/emilyhoughkovacs/blok-persona-clustering)** --- persona-based agents model real customer purchase intent and behavior. \
**[Build Your Own LLM](https://emilyhk.com/llm-workshop)** --- writeup from a hands-on workshop building a GPT-style model from scratch (PyTorch).

## Experience

**Reddit** --- Senior Data Scientist, Ads Marketplace \hfill March 2026 -- October 2026

- Owned data science for the identity matching and attribution domain, standing up its measurement foundation (metric taxonomy, pipelines, reporting) in a system that had no true measurement; validated engineering's opportunity-sizing against source data.
- Built two Airflow ETL pipelines powering an internal dashboard for ads-engineering data amendments and make-goods during account incident remediation, keeping billed and reported figures consistent while cutting manual ticket overhead.
- Built a supply-and-demand monitoring dashboard surfacing contextual ad-to-post relevance signals across the marketplace, informing inventory and pacing decisions.

**Meta** --- Senior Data Scientist, Reality Labs \hfill July 2024 -- August 2025

- Built and evaluated a random forest ensemble predicting user purchase intent, assessing performance tradeoffs.
- Built long-range forecasts for Lifestyle and Entertainment teams' key metrics, informing roadmap and resourcing decisions.
- Ran observational analyses of MR vs.\ fully immersive VR effectiveness, quantifying the impact of physical space on user engagement.

**Spotify** --- Data Scientist \hfill Aug 2022 -- March 2024 \
\mbox{}\hfill May 2016 -- May 2021

- Pioneered the metrics suite for the creator side of the music marketplace, adopted as the source of truth across creator-facing teams.
- Built monitoring for time-to-delivery of podcast content, surfacing supply-chain bottlenecks for podcast partnerships.
- Produced creator-side insights for Spotify Wrapped '22 and '23 (top editorial tracks, artists, albums), surfaced in Spotify's public, consumer-facing product.

**Tumblr** --- Product Analyst \hfill September 2014 -- October 2015

- Extracted business insights for a platform serving 250M+ blogs and 60M+ posts/day; automated reporting and built a Flask app to run and email ad-hoc Hive jobs.

## Education

**Barnard College, Columbia University** --- B.A., Mathematics / Computer Science \hfill May 2014

## Skills \& Tools

**Languages \& Libraries:** Python (pandas, NumPy, scikit-learn, statsmodels, matplotlib), SQL (expert) \
**Statistics \& Measurement:** statistical modeling, observational impact analysis, metric design \& source-of-truth definitions, forecasting, model evaluation \
**Data Platforms \& Pipelines:** GCP BigQuery, PostgreSQL, Hive, HDFS, Airflow, ETL, data pipelines
