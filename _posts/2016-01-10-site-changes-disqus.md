---
layout: post
title: Site Changes, Comments Added and Reasoning
description: A quick update on my blog, and why I am hesitant on adding commenting
tags: announcements
published: true
comments: true
---

Other than my one reader, I don't think there is anyone actually visiting my blog.  There has been a number of small and big changes to my blog, built with Jekyll and hosted with Github Pages.  A few more stylistic changes are in the pipe but nothing is confirmed yet.  I wanted to talk a bit about the changes, my philosophy and why I was hesitant on adding commenting to the website.

### Changes and Philosophy

What changed?  Well, I changed the bottom navbar to a non-fixed side bar.  I may end up changing to being fixed again but for now it is simple and unobtrusive for the reader.  In fact, my philosophy for this blog is to be minimalistic, and to be about the content first.  Thus, you are presented with the option to choose what you want to read, and read that one blog post.  Of course, scrolling back up to choose another post to read will be annoying to do, which means a chroniclized paginated blog layout would be ideal. This is in consideration still.

Furthermore, under the hood I cleaned up some of the HTML and CSS to optimize bytes and clean code style.  This is of no real concern to most people, in fact probably doesn't change anything much.  I am not minifying anything either so the savings are tiny -- fractions of modern connection speeds.  But that doesn't mean I am (somewhat) committed to making the website blazing fast on slower connections.  Somewhat being my recent photos aren't exactly tiny but a respectable size (under 1MB, often 700KB range).  

On top of this, I removed the Google Analytics code from my website for two reasons.  One being for maximizing connection speed, and second for privacy reasons.  I know I can be a bit of the hypocrite since I did start using Google Analytics (only to tell me that no one comes to my website) but I do want to minimize the amount of tracking on the web.  I want my readers to understand and appreciate privacy as their right to not have profiles built on them, and I'll at least to my part to try and curb that.

Finally, I realized my SEO was literally 0, so I have started to add some things to at least show up on searches.

### Comments, via Disqus

Now for the "controversial" change, adding comments via a third-party: Disqus.  I thought about adding comments to my blog for a while now.  Of course there are a few pros and cons to doing so.  The ability to engage with your reader(s) is important so I could get feedback on my content, or to answer questions someone might have, or build any kind of following.  This is what made Twitch.tv a thing: live spectating and the ability to interact with the streamer in real-time is a big deal for a lot of people.

Now, as a statically generated website hosted by Github Pages, this doesn't leave me with a lot of options to handle comments.  Comments usually will require a database to store the comments so that they can be fetched and loaded on the reader's browser.  However, Github Pages is very simple, and doesn't come with database access (nor Jekyll plugins, etc). So that means I would have to host the database and a small comment application on a VPS which will end up costing money, which isn't worth it at this point. On top of which, I would have to make sure the commenting system has no vulnerabilities to avoid any kind of XSS or SQL injections, both of which should be done already if I use an already made project though I am somewhat interested in building my own.

On a side note, I blog to write my thoughts to the internet, and $5/mo on a DigitalOcean droplet would be a waste for literally 1 comment a year.  I don't have any intentions going to become a full-time blogger or content producer (video, photography, articles).  I also am against ad-supported websites (due to the overwhelmingly number of bad advertisements, which may have tracking or malware) but not exactly against sponsored ads and content since those are controlled and less intrusive.  Anyways, that means donations which no one will donate (since no one reads this website) or paying out of my pocket, both of which requires this blog having enough traffic to make it "worth it".

Of course, there is some cool Github powered comments, where you could comment on Github, and even pull those comments via the API and add them to the website with some limitations.  This is a little limited, but it can work quite nicely.  The one problem is needing a Github account which would limit my content, since my content isn't usually code related anyways then my presumed core readers would have to create a new account to comment.

So I don't want to handle my own commenting system, due to complexity and cost.  I also want a simple system where a reader could easily leave a comment and not feel alienated by having to manage multiple accounts.  I also wanted to have absolute control of the comments, as in being able to delete or hide poor messages (ie, offensive materials, or blatant attacks) but I also want to make my comments as "free" as possible (as in, other than something harmful I would not censor any comments).  Github has crumbled to pressure before (read: C Plus Equality), and who knows what could happen in the future.

So the first thing I did was use Disqus, without looking at some alternatives, to see if it looked good and would work well in development.  Sure enough, it was easy to add to posts without thinking, and it looked good out of the box.  Furthermore, Disqus allows logins through big social media (Google, Facebook, Twitter) or with your e-mail.  Now, this is where I stopped and thought about it some more.  In the first part of this post I mentioned that I wanted maximal privacy (minimal social media) and maximum control of the comments.  This is clearly hypocrisy since Disqus is a third-party which I cannot ever control what happens in the back-end.  If you delete your comment, I cannot guarantee that it is gone *forever*.  I cannot guarantee that someone at Disqus doesn't end up censoring your comment in the future.  I don't think that any of these are actual problems someone on reading this blog will actually ever face, but this is about making a statement that I want your words to be your own, and that your stupid comment may not come back to bite you in 10 years.  I realize I'm not a privacy nut like RMS, but I do want to advocate your rights to privacy.

At the very least, I did enable guest posting on Disqus, which hopefully is anonymous enough for your usage.  In fact, I encourage you to use the Guest posting unless you really trust me or trust yourself to not make poor statements you will regret in the future.  I honestly don't think it is a true issue (yet) but I am telling you it is your choice between privacy and convenience.  You cannot have both.

If you wish to guest post (assuming you are not logged in), use the "Sign up" form and a checkbox with "I'd rather post as a guest" will appear.  You will still need to fill the name and e-mail address so I hope you have a throwaway e-mail or some random person may be getting put into Disqus's database.  

Finally, I also figured that adding some javascript to the website to be counter-productive to my philosophy.  I am considering a way to hide the Disqus comments unless you actively wish to load the Disqus comments, to save bytes (mobile users) and to avoid any Disqus cluttering your viewing pleasure.

In the future, I will consider some other kind of commenting system, maybe rolling my own for my own experience.  Thank you for reading this far, please tell me what you think (with the new comments!).
