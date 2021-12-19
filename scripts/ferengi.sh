# script which randomly shows Ferengi Rules of Acquisition

# Define Rules
# first value is number of rule. Second is rule itself.
# Each rule is separated by line for better readability

rules=(
    "0" "Always listen to the Grand Nagus" 
    "1" "Once you have their money, you never give it back."
    "2" "The best deal is the one that brings the most profit."
    "3" "Never spend more for an acquisition than you have to."
    "4" "Sedition and treason are always profitable."
    "5" "Always exaggerate your estimates."
    "6" "Never allow family to stand in the way of opportunity."
    "7" "Keep your ears open."
    "8" "Small print leads to large risk."
    "9" "Opportunity plus instinct equals profit."
   "10" "Greed is eternal."
   "13" "Anything worth doing is worth doing for money."
   "14" "Sometimes the quickest way to find profits is to let them find you."
   "15"	"Dead men close no deals."
   "16" "A deal is a deal."
   "17" "A contract is a contract is a contract… but only between Ferengi."
   "18" "A Ferengi without profit is no Ferengi at all."
   "19"	"Satisfaction is not guaranteed."
   "20"	"He who dives under the table today lives to profit tomorrow."
   "21" "Never place friendship above profit."
   "22" "A wise man can hear profit in the wind."
   "23" "Nothing is more important than your health… except for your money."
   "27"	"There's nothing more dangerous than an honest businessman."
   "29" "What's in it for me?"
   "30"	"Confidentiality equals profit."
   "31" "Never make fun of a Ferengi's mother. "
   "33" "It never hurts to suck up to the boss."
   "34" "War is good for business."
   "35" "Peace is good for business."
   "37"	"The early investor reaps the most interest."
   "39"	"Don't tell customers more than they need to know."
   "40"	"She can touch your lobes but never your latinum."
   "41"	"Profit is its own reward."
   "43"	"Feed your greed, but not enough to choke it."
   "44"	"Never confuse wisdom with luck."
   "45" "Expand or die."
   "47" "Don't trust a man wearing a better suit than your own."
   "48" "The bigger the smile, the sharper the knife."
   "52"	"Never ask when you can take."
   "53"	"Never trust anybody taller than you."
   "54"	"Rate divided by time equals profit."
   "55"	"Take joy from profit, and profit from joy."
   "57" "Good customers are as rare as latinum. Treasure them."
   "58"	"There is no substitute for success."
   "59"	"Free advice is seldom cheap."
   "60"	"Keep your lies consistent."
   "62" "The riskier the road, the greater the profit."
   "63"	"Work is the best therapy - at least for your employees."
   "65"	"Win or lose, there's always Hupyrian beetle snuff"
   "66"	"Someone's always got bigger ears."
   "68"	"Risk doesn't always equal reward."
   "69"	"Ferengi are not responsible for the stupidity of other races."
   "74" "Knowledge equals profit."
   "75" "Home is where the heart is, but the stars are made of latinum."
   "76"	"Every once in a while, declare peace. It confuses the hell out of your enemies."
   "77"	"If you break it, I'll charge you for it!"
   "79"	"Beware of the Vulcan greed for knowledge."
   "82"	"The flimsier the product, the higher the price."
   "85"	"Never let the competition know what you're thinking."
   "87"	"Learn the customer's weaknesses, so that you can better take advantage of him."
   "88"	"It ain't over 'til its over."
   "88"	"Vengeance will cost you everything."
   "89"	"Ask not what your profits can do for you, but what you can do for your profits."
   "89"	"[It is] better to lose some profit and live than lose all profit and die."
   "92"	"There are many paths to profit."
   "94"	"Females and finances don't mix."
   "95"	"Expand or die."
   "97"	"Enough... is never enough."
   "98"	"Every man has his price."
   "98"	"If you can't take it with you, don't go."
   "99"	"Trust is the biggest liability of all."
  "100"	"When it's good for business, tell the truth."
  "101"	"Profit trumps emotion."
  "102"	"Nature decays, but latinum lasts forever."
  "103"	"Sleep can interfere with opportunity."
  "104"	"Faith moves mountains... of inventory."
  "106"	"There is no honor in poverty."
  "108"	"Hope doesn't keep the lights on."
  "108"	"A woman wearing clothes is like a man without any profits."
  "109"	"Dignity and an empty sack is worth the sack."
  "110"	"Exploitation begins at home."
  "111"	"Treat people in your debt like family... exploit them."
  "112"	"Never have sex with the boss' sister."
  "113"	"Always have sex with the boss."
  "117"	"You can't free a fish from water."
  "121"	"Everything is for sale, even friendship."
  "122"	"Never Sleep with the bosses sister"
  "123"	"Even a blind man can recognize the glow of Latinum."
  "125"	"You can't make a deal if you're dead."
  "135"	"Listen to secrets, but never repeat them."
  "139"	"Wives serve, brothers inherit."
  "141"	"Only fools pay retail."
  "144"	"There's nothing wrong with charity... as long as it winds up in your pocket."
  "147"	"People love the bartender."
  "151"	"Even when you're a customer, sell yourself."
  "153"	"Sell the sizzle, not the steak."
  "162"	"Even in the worst of times someone turns a profit."
  "168"	"Whisper your way to success."
  "177"	"Know your enemies... but do business with them always."
  "181"	"Not even dishonesty can tarnish the shine of profit."
  "183"	"When life hands you ungaberries, make detergent."
  "184"	"A Ferengi waits to bid until his opponents have exhausted themselves."
  "188"	"Not even dishonesty can tarnish the shine of profit."
  "189"	"Let others keep their reputation. You keep their money."
  "190"	"Hear all, trust nothing."
  "192"	"Never cheat a Klingon... unless you're sure you can get away with it."
  "193"	"Trouble comes in threes."
  "193"	"It's never too late to fire the staff."
  "194"	"It's always good business to know about new customers before they walk in your door."
  "199"	"Location, location, location."
  "200"	"A Ferengi chooses no side but his own."
  "202"	"The justification for profit is profit."
  "203"	"New customers are like razor-toothed gree worms. They can be succulent, but sometimes they bite back."
  "208"	"Sometimes, the only thing more dangerous than a question is an answer."
  "211"	"Employees are the rungs on the ladder of success. Don't hesitate to step on them."
  "212"	"A good lie is easier to believe than the truth."
  "214"	"Never begin a (business) negotiation on an empty stomach."
  "216"	"Never gamble with a telepath."
  "217"	"Always know what you're buying."
  "217"	"You can't free a fish from water."
  "218"	"Sometimes what you get free costs entirely too much."
  "219"	"Possession is eleven-tenths of the law!"
  "223"	"Beware the man who doesn't take time for Oo-mox."
  "227"	"If that's what's written, then that's what's written."
  "229"	"Latinum lasts longer than lust."
  "235"	"Duck; death is tall."
  "236"	"You can't buy fate."
  "239"	"Never be afraid to mislabel a product."
  "240"	"Time, like latinum, is a highly limited commodity."
  "242"	"More is good... all is better."
  "243"	"Always leave yourself an out."
  "248"	"The definition of insanity is trying the same failed scheme & expecting different results."
  "255"	"A wife is luxury... a smart accountant a neccessity."
  "257"	"When the messenger comes to appropriate your profits, kill the messenger."
  "261"	"A wealthy man can afford anything except a conscience."
  "263"	"Never allow doubt to tarnish your lust for latinum."
  "266"	"When in doubt, lie."
  "267"	"If you believe it, they believe it."
  "272"	"Always inspect the merchandise before making a deal."
  "280"	"If it ain't broke, don't fix it."
  "284"	"Deep down, everyone's a Ferengi."
  "285"	"No good deed ever goes unpunished."
  "286"	"When Morn leaves, it's all over."
  "287"	"Always get somebody else to do the lifting."
  "288"	"Never get into anything that you can't get out of."
  "289"	"A man is only worth the sum of his possessions."
  "290"	"An angry man is an enemy, and a satisfied man is an ally."
  "291"	"The less employees know about the cash flow, the smaller the share they can demand."
  "292"	"Only a fool passes up a business opportunity."
  "293"	"The more time they take deciding, the more money they will spend."
  "294"	"A bargain usually isn't."
  "299"	"Whenever you exploit someone, it never hurts to thank them...That way it's easier to exploit them the next time."
  "431"	"When the shooting starts, let the mercenaries handle it!"
  )

# Loop and print it.  Using offset and length to extract values
COUNT=${#rules[@]}

# Create random number
random=$((0 + $RANDOM % $COUNT))

# Check if random number is even or odd
# If random number is odd then change it into even number
if [ $((random%2)) -ne 0 ];
then
    even=$((random+1))
else
    even=$random
fi

# Define numbers for selecting values from array
rule_number=$even
rule_text=$((even+1))

# Selecting rule number and rule text from array 
number=${rules[$rule_number]}
rule=${rules[$rule_text]}

# Output text
#   $number is number of rule
#   $rule is text of rule
# 
# Change to your liking. Choices are limitles

printf "\n  Ferengi Rules of Acquisition \n"
printf "  ============================\n\n"
printf "    Rule $number: $rule\n\n"

