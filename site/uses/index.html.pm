#lang pollen

◊title{"Uses This"}

◊div[#:class "epigraph"]{
  ◊blockquote[#:cite "https://usesthis.com/about/#:~:text=Have%20you%20considered%20added%20a%20%2Fuses%2F%20page%20to%20your%20own%20site%2C%20answering%20the%20same%20questions%3F"]{
    Have you considered adding a ◊code{/uses/} page to your own site, answering the same questions? 
    ◊footer{
      ◊link["https://wafer.baby/@d"]{Daniel} of ◊link["https://usesthis.com/about/#:~:text=Have%20you%20considered%20added%20a%20%2Fuses%2F%20page%20to%20your%20own%20site%2C%20answering%20the%20same%20questions%3F"]{usesthis.com}
    }
  }
}

◊section{
  ◊heading{Who are you, and what do you do?}
  I'm a professional software engineer and once engineering manager. I work a day job but I'm also working with a good friend and former boss to bring ◊link["https://screen.garden"]{screen.garden}, a real-time collaboration tool for PKMs and the web, to life.

  In my free time I sing with a local queer TTBB chorus, play table-top RPGs, watch Formula 1, and play video games.
}

◊section{
  ◊heading{What hardware do you use?}

  I work atop a sit-stand desk I bought when I first started working remotely in 2017. It stays in the "sit" position 99% of the time. For work I use whatever machine my employer provides. Right now that's a 14in M3 MacBook Pro. Personally, I have an M1 MacBook Air which I love. A single thunderbolt cable runs from either of those machines to a ◊link["https://www.caldigit.com/thunderbolt-station-4/"]{CalDigit TS4} which connects it to power, ethernet, a USB hub, and my display.

  I use just the one display, a ◊link["https://www.gigabyte.com/Monitor/M32U"]{GIGABYTE M32U}, which is a 32 inch, 4k, 144Hz monitor. Whenever someone is talking about replacing their monitor I always bring up refresh rate. It's one of those things that sounds like you wouldn't notice but it actually makes looking at a screen for most of your day a lot more pleasant. I've sat a no-name-brand monitor light and a Logitech webcam atop it.

  I have a collection of mechanical keyboards (◊link["https://ergodox-ez.com/"]{ErgoDox EZ}, ◊link["https://shop.keyboard.io/products/keyboardio-atreus"]{Keyboardio Atreus}, to name a couple) which all live in a drawer while I type away on my ◊link["https://www.gloriousgaming.com/products/glorious-gmmk-pro-75-barebone-black"]{Glorious GMMK Pro} with ◊link["https://www.gloriousgaming.com/products/glorious-panda-mechanical-switches?variant=37691905933487"]{Glorious Panda tactile switches}. I think Glorious's branding is a bit "cringe" to say the least but they were the only custom keyboard option I could get same-day at the nearby Micro Center when I needed to replace my ◊link["https://drop.com/buy/vortex-poker-iii-compact-keyboard"]{Pok3r} following a coffee spill incident.

  I talk to my coworkers and friends through a ◊link["https://www.bestbuy.com/site/blue-microphones-blue-yeti-professional-multi-pattern-usb-condenser-microphone/9737441.p?skuId=9737441"]{Blue Yeti mic} that I bought when a former employer gave everyone a couple hundred dollars for work-from-home equipment in early 2020 (despite my having already worked from my home my entire tenure there).

  At the edges of my desk are piles of scrunchies, a couple hair clips, my AirPods Pros, a pair of Sennheiser HD 600s, my iPhone 14 Pro Max (I always go "Max" or "Plus" for the extra battery life), an ◊link["https://www.aquaphorus.com/products/lip-care/lip-repair-stick"]{Aquaphor lip balm stick}, some hand lotion, and a nice candle.

  Away from my desk I have a collection of cameras but the one I use the most is my Leica M6 which I usually shoot with a Voigtlander Nokton Classic 35mm f/1.4. I digitize my negatives with a beat-up Sony a6000, a cheap macro lens, and a ◊link["https://www.valoi.co/easy35"]{Valoi easy35}.

  I have a couple Apple TV 4ks to stream content from the cloud and also the Plex Media Server running on a Synology NAS. I have a couple TVs in different rooms but the Xbox Series X stays connected to the 65 inch LG C1 OLED (once again which a high refresh rate).

  Finally, currently sitting on my nightstand wrapped in some FiiO IEMs is a 5th iPod Classic (aka an iPod Video) whose hard disk I've ◊link["https://www.iflash.xyz/"]{replaced with a 512gb microSD card}. It's really incredible how well it still works.
}

◊section{
  ◊heading{And what software?}

  These days I'm macOS all-the-way. I'm fully integrated into the ecosystem and the ergonomics and reliability of development on the platform is unparalleled in my opinion. Obviously I use a ton of software so I'll limit (mostly) to things I keep pinned to my dock (although most of the time I'm launching things from ◊link["https://www.alfredapp.com/"]{Alfred}):

  ◊unordered-list{
    ◊item{◊link["https://www.mozilla.org/en-US/firefox/new/"]{Firefox} to browse the web}
    ◊item{◊link["https://flexibits.com/fantastical"]{Fantastical} to manage several calendar accounts. I could just use Calendar.app but there are few features (like travel time and automatic event merging) that keep me renewing my subscription.}
    ◊item{Mail.app for emails...}
    ◊item{◊link["https://culturedcode.com/things/"]{Things 3} makes sure I get things done. I switched from an Android phone to an iPhone many years ago just so I could use Things while I was away from my computer.}
    ◊item{◊link["https://sw.kovidgoyal.net/kitty/"]{Kitty} to run all of my command line apps. I always work within a ◊code{tmux} session so my terminal emulator doesn't really matter all that much (because I'm never using tabs or splits or whatever) but Kitty is quick and the ◊link["https://github.com/DinkDonk/kitty-icon"]{alternative icon} I use for it is really cute. I'm a vim user (neovim really) and have been since 2015. My neovim setup could be its own post...}
    ◊item{Music - I switch between two libraries: 1. My local library which I sync with my iPod and 2. My iCloud, Apple Music backed library}
    ◊item{◊link["https://kapeli.com/dash"]{Dash 6} (usually via Alfred) to quickly reference documentation. Elixir / Hex package docs support is incredible}
    ◊item{◊link["https://obsidian.md"]{Obsidian} for personal, work, and TTRPG notes. I keep my plugins list slip with just Templater, DataView, Tasks, Periodic Notes, and of course screen.garden.}
    ◊item{◊link["https://readwise.io/read"]{Readwise Reader} as my read-later service}
  }

  I have to shout-out Lightroom with ◊link["https://www.negativelabpro.com/"]{Negative Lab Pro} for converting scans/photos of film negatives.
}


◊section{
◊heading{What would be your dream setup?}
  I've obviously spoiled myself already so I'd keep most things the same but...

  I'd love a thunderbolt KVM of some kind that would let me swap ◊em{quickly} between machines at the press of a button. I also feel like I'd benefit from a larger desk.

  I think about replacing my webcam with the Sony a6000 and replacing that with a newer, higher resolution mirrorless camera.

  I'm really hoping the ARM desktop / server market continues to become more accessible to the consumer market because the Synology NAS is looking a little worse-for-wear these days. I've thought about replacing it with a custom build x64 machine but the additional power consumption and heat keep me from doing it (I'm spoiled by these Apple ARM machines...).
}
