#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx::Log
  class XML
    # "svn log -r19:5"
    LINES = Array.new.tap do |a|
      a << '<?xml version="1.0"?>'
      a << '<log>'
      a << '<logentry'
      a << '   revision="19">'
      a << '<author>Lili von Shtupp</author>'
      a << '<date>2012-09-16T14:24:07.913759Z</date>'
      a << '<msg></msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="18">'
      a << '<author>Lili von Shtupp</author>'
      a << '<date>2012-09-16T14:09:45.398182Z</date>'
      a << '<msg>Willkommen, Bienvenue, Welcome, C\'mon in.</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="17">'
      a << '<author>Hedley Lamarr</author>'
      a << '<date>2012-09-16T14:07:53.963478Z</date>'
      a << '<msg>Here, sir, play with this.</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="16">'
      a << '<author>Buddy Bizarre</author>'
      a << '<date>2012-09-16T14:07:30.329525Z</date>'
      a << '<msg>CUT! What in the hell do you think you\'re doing here? This is a closed set.</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="15">'
      a << '<author>Mongo</author>'
      a << '<date>2012-09-16T14:02:05.414042Z</date>'
      a << '<msg>Mongo only pawn in the game of life.</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="14">'
      a << '<author>Hedley Lamarr</author>'
      a << '<date>2012-09-16T14:01:27.015648Z</date>'
      a << '<msg>Chewing gum on line, eh? I hope you brought enough for everybody.</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="13">'
      a << '<author>Jim</author>'
      a << '<date>2012-09-16T13:51:55.741762Z</date>'
      a << '<msg>We\'re not sure. Are we...black?</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="12">'
      a << '<author>Lili von Shtupp</author>'
      a << '<date>2012-09-16T13:50:08.686859Z</date>'
      a << '<msg>A wed wose. How womantic.</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="11">'
      a << '<author>Mongo</author>'
      a << '<date>2012-09-16T13:40:13.815771Z</date>'
      a << '<msg>Huh-huh, naw, Mongo straight.</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="10">'
      a << '<author>Olson Johnson</author>'
      a << '<date>2012-09-16T13:39:26.300719Z</date>'
      a << '<msg>What are we made of? Our fathers came across the prairies, fought Indians, fought drought,'
      a << 'fought locusts, fought Dix... remember when Richard Dix came in here and tried to take over this'
      a << 'town? Well, we didn\'t give up then, and by gum, we\'re not going to give up'
      a << 'now!</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="9">'
      a << '<author>Buddy Bizarre</author>'
      a << '<date>2012-09-16T13:38:01.073277Z</date>'
      a << '<msg>Watch me! It\'s so simple! Give me the playback!</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="8">'
      a << '<author>Lili von Shtupp</author>'
      a << '<date>2012-09-16T13:37:07.366597Z</date>'
      a << '<msg>Vhy don\'t you admit it? He\'s too much of man for you. I know. You\'re going to need an army to'
      a << 'beat him! You\'re finished. Fertig! Verfallen! Verlumpt! Verblunget!'
      a << 'Verkackt!</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="7">'
      a << '<author>Governor William J. Le Petomane</author>'
      a << '<date>2012-09-15T17:32:40.333026Z</date>'
      a << '<msg>It is?</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="6">'
      a << '<author>Olson Johnson</author>'
      a << '<date>2012-09-15T17:32:11.103879Z</date>'
      a << '<msg>Now who can argue with that? I think we\'re all indebted to Gabby Johnson for clearly stating'
      a << 'what needed to be said. I\'m particulary glad that these lovely children were here today to'
      a << 'hear that speech. Not only was it authentic frontier gibberish, it expressed a courage little'
      a << 'seen in this day and age.</msg>'
      a << '</logentry>'
      a << '<logentry'
      a << '   revision="5">'
      a << '<author>Lyle</author>'
      a << '<date>2012-09-15T17:30:36.869900Z</date>'
      a << '<msg>Send wire, main office, tell them I said "ow". Gotcha!</msg>'
      a << '</logentry>'
      a << '</log>'
    end
  end
end
