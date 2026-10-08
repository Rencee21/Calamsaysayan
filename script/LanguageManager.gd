extends Node

signal language_changed(lang)
var current_language: String = "fil"  # Default language (English)

# === Translations ===
var translations = {
	"en": {
		"yes" : "Yes",
		"no" : "No",
		"mainmenu":"Mainmenu",
		"next" : "Next",
		"resume": "Resume",
		"back": "Back",
		"mute_music": "Mute Music",
		"language": "Tagalog",
		"sound":"Sound",
		"start":"Start",
		"options":"Options",
		"quit":"Quit",
		
		#CCC_PROLOGUE
		"ccc_prologue" : "Hi, Scholar, I have a subject/assignment 
		that I will give you today.",
		"ccc_prologue2" : "An assignment for your future journey.",
		"ccc_prologue3" : "From your starting place, where the name 
		Calamba originated, which also serves as 
		one of the landmarks in this place,",
		"ccc_prologue4" : "and that is the Giant Claypot or 'kalanbanga.'",
		"ccc_prologue5" : "You need to acquire knowledge before you 
		can enter the City College of Calamba, and if 
		you pass this,",
		"ccc_prologue6" : "you will have the opportunity to 
		answer an examination here at the 
		City College of Calamba.",
		"ccc_prologue7" : "You can now go to the map towards 
		your first location, which is 
		the Giant Claypot.",
		
		
		#PROLOGUE_CUT_SCENE
		"prologue1":"Calamba City, nestled at the foot of Mount Makiling and beside Laguna de Bay, is one of the most historic places in the Philippines.
Once part of Tabuco (now Cabuyao), it became an independent pueblo in 1742 and later grew into a prosperous town.",
		"prologue2":"Its name comes from a legend—Spanish soldiers once asked a woman the place’s name, and she answered with what she was carrying:
 a clay stove (kalan) and a water jar (banga). From this, the name Calamba was born, now symbolized by the giant clay pot in the city plaza.",
		"prologue3":"Calamba is best known as the birthplace of Dr. José Rizal, the national hero of the Philippines, who was baptized in the old Saint
John the Baptist Parish Church in 1861. Despite tragedies like the burning of its church and the massacre during World War II, the city rebuilt 
itself,preserving its heritage through the Rizal Shrine and historical landmarks.",
		"prologue4":"On April 21, 2001, Calamba was officially declared a city, marking its transformation from a humble settlement
 to a thriving cultural and historical hub of Laguna.",
		"prologue5" : "Calamba City, nestled at the foot of Mount Makiling and beside Laguna de Bay, 
is one of the most historic places in the Philippines. Once part of Tabuco
 (now Cabuyao), it became an independent pueblo in 1742 and later grew 
into a prosperous town. Its name comes from a legend—Spanish soldiers 
once asked a woman the place’s name, and she answered with what she was 
carrying: a clay stove (kalan) and a water jar (banga). From this, 
the name Calamba was born, now symbolized by the giant clay pot in the 
city plaza. On April 21, 2001, Calamba was officially declared a city, 
marking its transformation from a humble settlement
 to a thriving cultural and historical hub of Laguna.
Calamba City. (n.d.). Calambacity.gov.ph. 
https://calambacity.gov.ph/Users/TheCity/CityProfile
‌",

#INSTRUCTION_SCENE [MAP_PART]
		"instruct1" : "Your journey will begin here.",
		"instruct2" : "Here are the four important landmarks in the area of Calamba",
		"instruct3" : "In every place, you will have missions",
		"instruct4" : "And your first destination is the 'kalanbanga'
		where the name Calamba originated",
		"instruct5" : "Once you complete each mission, you will gain
		knowledge points and the three other places will be unlocked",
		"instruct6" : "Now, you can start your
		mission.",

#KALABANGA_SCENE 
		"vendor1" : "Oh, you look hungry! I sell fishballs and snacks.",
		"vendor2" : "...But it seems like you don't have enough coins.",
		"vendor3" : "Hmm... I can give you food in exchange for knowledge.",
		"vendor4" : "Do you want to try answering a difficult question about our town's Giant Claypot? 
		Or maybe you'd prefer to find some coins first?",
		"vendor5" : "Choose\n
		A. Path A \n
		B. Path B",
		"vendor6" : "The Giant Claypot, or KalanBanga, is a symbol of our city, Calamba.",
		"vendor7" : "The word 'Calamba' itself comes from 'kalan' (stove) and 'banga' (clay pot), which 
		means 'kalanbanga' or claypot.",
		"vendor8" : "The claypot represents the town's rich culture and history. You can see it 
		standing proudly in the town plaza, a reminder of our origins.",
		"vendor9" : "Now, here is your test. Answer it correctly, and you'll get it for free.",
		"vendor10" : "Why is the Giant Claypot (KalanBanga) important to the history of Calamba?\n
		A. It symbolizes the town's origin from the words 'kalan' and 'banga'\n
		B. Dr. Jose Rizal used it as a cauldron\n
		C. It is just a decoration with no meaning",
		"vendor11" : "Correct! You know its history well. This free fishball is for you.",
		"vendor12" : "Hmm... that's not right. Just go look for some coins instead.",
		"vendor13" : "It's alright, don't worry. If you don't know the answer, you can go around and ask. 
		Maybe someone will help you and give you a coin.",
		"vendor14" : "Ah, you have a coin now! That's good. Here are the fishballs!",
		"npc_coin1" : "Hi, where are you from?",
		"npc_coin2" : "Ah, you're looking for a coin? I'll give you one, but first... You must answer my 
		question about the Giant Claypot!",
		"npc_coin3" : "The Giant Claypot in Calamba Plaza is the biggest claypot in town. It has the 
		names of all the Calamba barangays (villages) written on it. It serves as a symbol 
		of unity and identity for the people here.",
		"npc_coin4" : "Where can you find the Giant Claypot (KalanBanga)?\n
		A. Calamba Plaza\n
		B. Luneta Park\n
		C. Intramuros",
		"npc_coin5" : "Wrong! Let's try again.",
		"npc_coin6" : "What is written on the surface of the Giant Claypot?\n
		A. Names of the Calamba barangays\n
		B. Famous quotes by Rizal\n
		C. Recipes for cooking 'banga' (pot)",
		"npc_coin7" : "Exactly! Here, take this coin as your reward.",
		
#RIZALSHRINE_SCENE
	"rizal1" : "Welcome, scholar, to the Rizal Shrine, also known as Rizal's House.
		This house is the place that was home to our national hero,
		Dr. José Protacio Rizal Mercado y Alonzo Realonda.",
		"rizal2" : "He was born here on June 19, 1861, to Francisco Mercado and 
		Teodora Alonso.",
		"rizal3" : "This 'bahay-na-bato' (stone house) reflects the lifestyle of the 
		'principalia,' or the higher-class families, during the 
		Spanish colonial period.",
		"rizal4" : "Rizal spent his childhood here, where he learned the value of hard work,
		a love for learning, and compassion for others, which molded him into a 
		Filipino who fought using his pen rather than weapons.",
		"rizal5" : "The original house was destroyed during World War II, but it was faithfully
		reconstructed in the 1950s and later declared a national shrine.",
		"rizal6" : "Today, it stands as a proud reminder of Rizal's humble beginnings and his
		legacy of patriotism and nationalism.",
		"rizal7" : "Before I test your knowledge, you first need to find two important items
		around this shrine:
		A Quill Pen – a symbol of Rizal's writings that awakened the nation.
		A Book – representing his thirst for knowledge and education.",
		"rizal8" : "Bring these to me, and only then can you answer the question for the 
		exam.Complete this mission, and you can continue your journey to 
		another landmark.",
		"rizal9" : "Excellent! You have found the items that represent Rizal's mind and spirit.
		Now, let's see if you truly learned something about this place.",
		"rizal10" : "Question 1: Who wrote Noli Me Tangere and El Filibusterismo?

		A. Andres Bonifacio
		B. Emilio Aguinaldo
		C. José Rizal
		",
		"rizal11" : "Question 2: What happened to the original Rizal's House during
		World War II?

		A. It survived untouched
		B. It was destroyed
		C. It was moved to another town
		",
		"rizal12" : "Very good! You have proven your knowledge. You can now continue your
		journey towards the St. John the Baptist Church.",
		"rizal13" : "Hmm... not quite. Think carefully again, student. Rizal's story is more
		deserving of being remembered correctly. Try again.",
		"book1" : "You discovered a Book — This is a symbol of Rizal's love 
		for learning.",
		"book2" : "From a young age, Rizal was a dedicated student.",
		"book3" : "He studied in Manila at the Ateneo Municipal and later in 
		Europe,where he mastered many languages and became a 
		doctor, writer,and scientist.",
		"book4" : "This book represents his belief that education is the key to 
		elevating the nation.",
		"pencil1" : "You found an old Quill Pen. This represents Rizal's powerful 
		writings that awakened the Filipino spirit.",
		"pencil2" : "Through his novels Noli Me Tángere (1887) and El Filibusterismo 
		(1891),he exposed the injustices of the Spanish rule.",
		"pencil3" : "Unlike other revolutionaries, Rizal chose the pen over the 
		sword — inspiring Filipinos to fight for freedom through 
		knowledge and unity.",

#CHURCH_SCENE
	"church1" : "Welcome, my child, to the St. John the Baptist Parish Church here 
	in Calamba.You are inside now and witnessing the presence of faith, 
	hardship, change, and the shaping of 
	a person.",
		"church2" : "I see you have arrived with a sincere and believing heart. Let me share 
		the stories with you, so you can understand why this place is 
		more than just stone and wood.",
		"church3" : "This parish was formally established in 1779, when Calamba became 
		independent from the parochial church of Cabuyao. Jesuit missionaries 
		first acquired the land here, called the Hacienda de San Juan, 
		for their missions.",
		"church4" : "In 1859, a stone church in the Baroque style was constructed. However, 
		during World War II, in 1945, this structure was destroyed. The altar 
		had previously burned down in 1862, but it was immediately 
		rebuilt at that time.",
		"church5" : "After the war, the restoration was led by Father Eliseo Dimaculangan. 
		Furthermore,the young José Rizal, our national hero, was baptized 
		here on June 22, 1861, by Fr. Rufino Collantes; and 
		his godfather was Fr. PEDRO CASANAS.",
		"church6" : "The baptistery, where that sacred act took place, is recognized as 
		a National Historical Landmark. Although many original records were 
		lost—the canonical books burned in 1862—most of the originals 
		destroyed at the altar have either been restored or 
		replaced with new ones...",
		"church7" : "Inside, you can still see the stained-glass windows
		depicting the saints, the seven sacraments, and at the entrance are 
		two stained glasses: Saint Dominic and San Lorenzo Ruiz. There 
		was also a garden called the Garden of Gethsemane, with the 
		Stations of the Cross and a “Well of Repentance” 
		(Balon ng Pagbabalik Loob).",
		"church8" : "All this history testifies to our faith and reminds us of our origins, 
		our struggles, and our refuge as believers.",
		"church9" : "To better preserve the memories concerning the baptismal record
		of our national hero, I am giving you a puzzle to solve,
		where you need to find the correct button to reveal the master 
		registry containing the baptisms held here. I will entrust this 
		book to you, and if you fail to answer it, you will have 
		to start over from the beginning.",

		#Puzzle_Part
		"masterreg1" : "An ancient record book from the St. John the Baptist Church.
		It holds the names of generations baptized here, including that of José Rizal in 1861.
		Though scarred by fire and time, it remains a symbol of faith, memory, and 
		the enduring spirit of the community.",
		
		
#CCC_INSIDE
		"ccc1" : "Welcome, Scholars! You are now inside the City College 
		of Calamba...",
		"ccc2" : "but did you know that this place was once 
		the Old Municipal Building of Calamba?",
		"ccc3" : "In the past, this was the center of governance, where 
		town leaders gathered and made important 
		decisions for the community.",
		"ccc4" : "Today, it is not only a reminder of our civic past",
		"ccc5" : "but also a place of learning—where young Calambeños 
		shape their future.",
		"ccc6" : "History and education walk hand-in-hand in this very building.",
		"ccc7" : "Let's see if you were listening well. Answer my questions correctly, and you 
		will pass here at the City College of Calamba!",
		"ccc_q1": "Question 1:\nWhat was the former use of the building where the 
		City College of Calamba is located?\nA. Market\nB. Municipal Hall\nC. Church",
		"ccc_q2": "Question 2:\nWhat is the current use of this building?\n\nA. Museum\nB. University Hospital\nC. City College of Calamba",
		"ccc_correct1": "Correct! This building once served as the municipal hall.",
		"ccc_incorrect1": "Wrong...Just Try Again!",
		"ccc_correct2": "Excellent! Currently, this historical building is the 
		City College of Calamba.\nYou may now return to the map to go to the credits scene.",
		"ccc_incorrect2": "Wrong...Just Try again!",
		
#ASSESSMENT_SCENE
	"assessment1" : "You’ve explored Calamba’s treasures — from the Giant 
	Claypot to Rizal’s humble home and the old church by 
	the plaza.",
	"assessment2" : "Before you enter the City College of Calamba, let’s see 
	how deeply you’ve understood the stories behind each 
	place.",
	"assessment3" : "Think carefully. The answers are hidden in what you’ve 
	already seen and learned.",
	"assessment4" : "In Calamba’s official seal, a clay pot (banga) is shown. 
	You’ve seen it many times before — standing proudly at the 
	town plaza. But what deeper meaning does it hold?

	A. It only represents the ancient tools of the people.
	B. It symbolizes Calamba’s creativity and livelihood, showing 
	how simple things can represent identity.
	C. It is merely a decoration from Spanish times.",
	"assessment5" : "At the Rizal Shrine, every corner reflects the way young 
	José Rizal was raised. You’ve walked through those rooms 
	— the kitchen, the study, the chapel. What lesson does his 
	home teach us?

	A. That hard work, faith, and discipline built the foundation of 
	his greatness.
	B. That he lived a luxurious life full of servants and comfort.
	C. That his achievements came from talent alone.",
	"assessment6" : "Remarkable! You didn’t just remember facts — you 
	understood the heart of Calamba’s heritage. 
	You may now step into the City College of Calamba.",
	"assessment7" : "You’ve seen the places, but their meaning hasn’t fully 
	settled in your heart. Reflect again on the stories 
	each landmark told you, then return.",

#TUTORIAL_KALANBANGA
		"tips" : "TIPS",
		"t_banga2" : "This is you, the player.",
		"t_banga3" : "This symbol Indicates 
		to talk and quest",
		"t_banga4" : "Use this button if you 
		choose A in a question",
		"t_banga5" : "Use this button if you 
		choose B  in a question",
		"t_banga6" : "Use this button if you 
		choose C  in a question",
		"t_banga7" : "Use this button for next and
		interact objects.",
		
		
#TUTORIAL_RIZAL
		"t_rizal1" : "You can touch this button 
		 if you want to view 
		the option menu",
		"t_rizal2" : "This symbol indicates a important 
		objective for your quest.",
		"t_rizal3" : "You can step on this
		 to teleport to the map.",

#TUTORIAL_CHURCH
		"t_church1" : "You can step on this for solving the 
		puzzle.",
		"t_church2" : "HINT FOR PUZZLE",
		"t_church3" : "Left button is equal to 1. 
		Middle button is equal to 2.
		Right button is equal to 3.
		It can be use for solving the 
		puzzle quest.",
		"t_church4" : "You can step on three (3) times in a one button.",
		"t_church5" : "Read carefully the dialogue in father NPC
		 and there was a CAPITAL Sentence for a clue.",

#TUTORIAL_CCC
		"t_ccc1" : "City College of Calamba was founded in 2006 — the 
		same year that marked José Rizal’s 145th birth
		anniversary!",
		"t_ccc2" : "CCC was built to give affordable and quality 
		education to Calambeños who dream big but can’t 
		afford expensive schools.",
		"t_ccc3" : "The college’s core values spell RIZAL — Resilient, 
		Integrity-driven, Zealous, Adaptable, and Lifelong 
		Learner!",
		"t_ccc4" : "CCC stands on the old Calamba Municipal site, 
		preserving a part of the city’s history while 
		shaping its future.",
		"t_ccc5" : "CCC is CHED-recognized and ALCUCOA-accredited, 
		ensuring top-quality education that meets national 
		standards.",

		"trivia" : "TRIVIA AND FACTS",
		"dyk" : "Did you know?💡",
		"facts" : "FACTS",

#CONTROL_SYSTEM
		"control1" : "Use to move down",
		"control2" : "Use to move left",
		"control3" : "Use to move up",
		"control4" : "Use to move right",


		"cong1" : "Congratulations! for finishing the game.",
		"cong2" : "Do you want to restart again?",
		"cong3" : "Are you sure you want to quit?",
		"cong4" : "Thank you for playing!",
		
		"go_map" : "Go to Map",
		
		"choice1" : "",
		"choice2" : "",
		"choice3" : "",
		"choice4" : "",
		"choice5" : "",
		"npcchoice1" : "",
		"npcchoice2" : "",
		"npcchoice3" : "",
		"npcchoice4" : "",
		"npcchoice5" : "",
		"npcchoice6" : "",
		
		"quest_tourguide": "Quest: Talk to the tourguide",
		"quest_collect": "Quest: Find and collect books and pencil",
		"quest_return": "Quest: Go back to the tourguide",
		"quest_complete_rizal": "Quest Completed: Rizal Shrine",
		"collected_label_book" : "Book Collected!",
		"collected_label_pencil" : "Pencil Collected!",
		
		"quest_ccc1" : "Quest : Talk to professor",
		"quest_ccc2" : "Quest : Answer the quiz",
		"quest_ccc3" : "Quest Completed : CCC",
		
		"banga1" : "Quest : Buy to the vendor",
		"banga2" : "Quest : Find coin",
		"banga3" : "Quest : Go back to the vendor",
		"banga4" : "Quest Completed: KalanBanga!",
		
		"quest_church1" : "Quest : Talk to Father",
		"quest_church2" : "Quest : Solve the puzzle quest by stepping the 
		three (3) button icon, you will have three (3) tries only.\n
		Hint : How many godfather does rizal have?",
		"quest_church3" : "Quest : Go pick-up the object",
		"quest_church4" : "Quest Completed : Church",
		"masstereg" : "Master Registry Collected!",
		"map" : "Quest : Go to the KalanBanga",
		"portal" : "Quest : Quest Completed, go to the portal",
		"all_quests_complete": "All quests complete! Going to the final scene soon...",
		
		"map_instruction_complete": "Map tutorial completed! You can go to kalanbanga now.",
		"quest_already_finished": "You already finished this quest!",
		"need_finish_kalanbanga": "You must finish KalanBanga first!",
		"need_finish_rizal": "You must finish Rizal Shrine first!",
		"need_finish_church": "You must finish the Church quest first!",


	},
	"fil": {
		"yes" : "Oo",
		"no" : "Hindi",
		"mainmenu" : "Pangunahing Menu",
		"next":"Tuloy",
		"resume": "Ipagpatuloy",
		"back": "Bumalik",
		"mute_music": "Patayin ang Musika",
		"language": "Tagalog",
		"sound":"Tunog",
		"start":"Magsimula",
		"options":"Opsyon",
		"quit":"Umalis",
		
		#CCC_PROLOGUE
		"ccc_prologue" : "Hi, Iskolar ngayon ay may ipapagawa ako 
		sa'yong asignatura",
		"ccc_prologue2" : "asignatura para sa iyong magiging 
		paglalakbay.",
		"ccc_prologue3" : "Mula sa iyong pagsisimulaang lugar, na kung 
		saan nagsimula ang pangalang Calamba,
		na ito rin ang nagsisilbing isa sa mga 
		landmark sa lugar na ito",
		"ccc_prologue4" : "at ito ay  ang GiantClaypot o kalanbanga.
		",
		"ccc_prologue5" : "Kailangan mong makakuha ng mga kaalaman 
		bago ka, makapasok sa City College of 
		Calamba, at kapag ito ay naipasa mo",
		"ccc_prologue6" : "ay magkakaroon ka ng pagkakataon upang 
		makapagsagot ng pagsusulit mula dito sa 
		City College of Calamba.",
		"ccc_prologue7" : "Ngayon ay pwede ka nang pumunta sa mapa 
		patungo sa iyong unang lokasyon na ang 
		giant claypot.",
		
		
		#PROLOGUE_CUT_SCENE
		"prologue1":"Ang Lungsod ng Calamba, na matatagpuan sa paanan ng Bundok Makiling at sa tabi ng Laguna de Bay, ay isa sa pinakamakasaysayang lugar sa
Pilipinas.Dating bahagi ng Tabuco (ngayon ay Cabuyao), ito ay naging isang malayang pueblo noong 1742 at kalaunan ay lumago bilang isang 
maunlad na bayan.",
		"prologue2":"Ang pangalan nito ay nagmula sa isang alamat—Minsan tinanong ng mga sundalong Espanyol ang isang babae ng pangalan ng lugar, at sinagot
niya kung ano ang kanyang dala:isang clay stove (kalan) at isang water jar (banga). Mula rito, isinilang ang pangalang Calamba, na ngayon ay 
sinasagisag ng higanteng palayok na luwad sa plaza ng lungsod.",
		"prologue3":"Kilala ang Calamba bilang lugar ng kapanganakan ni Dr. José Rizal, ang pambansang bayani ng Pilipinas, na nabinyagan sa matandang San Juan na
Baptist Parish Church noong 1861. Sa kabila ng mga trahedya tulad ng pagkasunog ng simbahan nito at ang masaker noong World War II, muling 
itinayo ng lungsod ang sarili nito,pagpapanatili ng pamana nito sa pamamagitan ng Rizal Shrine at mga makasaysayang palatandaan.",
		"prologue4":"Noong Abril 21, 2001, opisyal na idineklara ang Calamba bilang isang lungsod, na minarkahan ang pagbabago nito mula sa isang hamak na 
pamayanan sa isang umuunlad na kultural at makasaysayang sentro ng Laguna.",
		"prologue5" : "Calamba City, na matatagpuan sa paanan ng Bundok Makiling at sa 
		tabi ng Laguna de Bay, ay isa sa pinaka makasaysayang lugar sa Pilipinas. 
		Sa sandaling bahagi ng Tabuco (Cabuyao ngayon), ito ay naging isang 
		malayang pueblo noong 1742 at kalaunan ay lumago sa isang maunlad na 
		bayan. Ang pangalan nito ay nagmula sa isang alamat—mga sundalong 
		Espanyol minsan nagtanong sa isang babae ng pangalan ng lugar, at 
		sinagot niya kung ano siya dala: isang luwad na kalan (kalan) at 
		isang banga ng tubig (banga). Mula dito, isinilang ang pangalang 
		Calamba, na ngayon ay sinasagisag ng higanteng palayok na luwad 
		sa plaza ng lungsod. Noong Abril 21, 2001, opisyal na idineklara ang 
		Calamba bilang isang lungsod, pagmamarka ng pagbabago nito mula sa 
		isang hamak na pamayanan sa isang umuunlad na kultural at makasaysayang 
		sentro ng Laguna.Calamba City. (n.d.). Calambacity.gov.ph. 
		https://calambacity.gov.ph/Users/TheCity/CityProfile
‌",

#INSTRUCTION_SCENE[MAP_PART]

		"instruct1" : "Dito magsisimula ang iyong paglalakbay.",
			"instruct2" : "Narito ang apat na mahahalagang Landmark dito sa 
			lugar ng Calamba",
			"instruct3" : "Sa bawat lugar ay magkakaroon ka ng mga misyon",
			"instruct4" : "At ang una mong patutunguhan ay ang kalanbanga
			na kung saan nagsimula ang pangalan ng calamba",
			"instruct5" : "Kapag natapos mo ang bawat misyon ay magkakaroon
			ka ng knowledge points at mabubuksan ang tatlo pang lugar",
			"instruct6" : "Ngayon, pwede mo nang simulan ang iyong
			misyon.",
			
#KALABANGA_SCENE
		"vendor1" : "Oh, mukhang gutom ka! Nagtitinda ako ng fishball at meryenda.",
				"vendor2" : "...Pero parang kulang ang mga barya mo.",
				"vendor3" : "Hmm... kaya kitang bigyan ng pagkain kapalit ng kaalaman.",
				"vendor4" : "Gusto mo bang subukang sagutin ang isang mahirap na tanong tungkol sa 
				Giant Claypot ng ating bayan? O baka mas gusto mo munang maghanap ng barya?",
				"vendor5" : "Pumili\n
				A. Path A \n
				B. Path B",
				"vendor6" : "Ang Giant Claypot, o KalanBanga, ay simbolo ng ating lungsod, Calamba.",
				"vendor7" : "Ang salitang 'Calamba' mismo ay nagmula sa 'kalan' at 'banga' na 
				nangangahulugang kalanbanga o claypot.",
				"vendor8" : "Ang claypot ay kumakatawan sa mayamang kultura at kasaysayan ng bayan. 
				Makikita mo itong nakatayo nang buong pagmamalaki sa plaza ng bayan, isang 
				paalala ng ating pinagmulan.",
				"vendor9" : "Ngayon, ito ang pagsubok mo. Sagutin ito ng tama, at makakalibre ka.",
				"vendor10" : "Bakit mahalaga ang Giant Claypot (KalanBanga) sa kasaysayan ng Calamba?\n
				A. Ito ay sumisimbolo sa pinagmulan ng bayan mula sa mga salitang kalan at banga\n
				B. Ginamit ito ni Dr. Jose Rizal bilang kaldero\n
				C. Isa lamang itong palamuti na walang kahulugan",
				"vendor11" : "Tama! Alam mo nang husto ang kasaysayan nito. 
				Ito para sa'yo ang libreng fishball na ito.",
				"vendor12" : "Hmm... hindi tama. Maghanap ka nalang ng barya.",
				"vendor13" : "Sige, huwag kang mag-alala. Kung hindi mo alam ang sagot, 
				maaari kang umikot at magtanong. Baka may tumulong sa iyo at bigyan ka 
				ng barya.",
				"vendor14" : "Ah, may barya ka na! Ayus yan. Oh ito na yung fishballs!",
				"npc_coin1" : "Hi, taga saan ka?",
				"npc_coin2" : "Ah, naghahanap ka ng barya? Bibigyan kita, pero una... 
		Dapat mong sagutin ang tanong ko tungkol sa Giant Claypot!",
				"npc_coin3" : "Ang Giant Claypot sa Calamba Plaza ay ang pinakamalaking claypot sa bayan. 
				Ito ay may mga pangalan ng lahat ng barangay ng Calamba na nakasulat dito. 
				Ito ay nagsisilbing simbolo ng pagkakaisa at pagkakakilanlan para sa mga tao 
				dito.",
				"npc_coin4" : "Saan mo makikita ang Giant Claypot (KalanBanga)?\n
				A. Calamba Plaza\n
				B. Luneta Park\n
				C. Intramuros",
				"npc_coin5" : "Mali! Subukan nating muli.",
				"npc_coin6" : "Ano ang nakasulat sa ibabaw ng Giant Claypot?\n
				A. Pangalan ng mga barangay ng Calamba\n
				B. Mga sikat na quotes ni Rizal\n
				C. Mga recipe para sa pagluluto ng banga",
				"npc_coin7" : "Eksakto! Narito, kunin mo ang baryang ito bilang iyong gantimpala.",
				
#RIZALSHRINE_SCENE
		"rizal1" : "Maligayang pagdating, iskolar, sa Rizal Shrine, na kilala rin bilang Bahay ni 
		Rizal. Ang bahay na ito ay ang lugar na tahanan ng ating pambansang 
		bayani, na si Dr. José Protacio Rizal Mercado y Alonzo Realonda.",
				"rizal2" : "Isinilang siya rito noong Hunyo 19, 1861, nina Francisco Mercado at 
				Teodora Alonso.",
				"rizal3" : "Ang bahay-na-bato na ito ay sumasalamin sa pamumuhay ng mga 
				principalia, o mas mataas na uri ng mga pamilya, noong panahon ng 
				kolonyal nang mga Espanyol.",
				"rizal4" : "Ginugol ni Rizal ang kanyang pagkabata dito, kung saan natutunan niya 
				ang halaga ng pagsusumikap, pagmamahal sa pag-aaral, at pakikiramay sa 
				kapwa mag-aaral na humubog sa kanya bilang isang pilipino na lumaban 
				gamit ang kanyang panulat kaysa sa mga sandata.",
				"rizal5" : "Ang orihinal na bahay ay nawasak noong Ikalawang Digmaang Pandaigdig, 
				ngunit ito ay matapat na itinayo noong 1950s at kalaunan ay 
				naideklarang isang pambansang dambana.",
				"rizal6" : "Ngayon, ito ay nakatayo bilang isang ipinagmamalaking paalala ng abang 
				pinagmulan ni Rizal at ang kanyang pamana ng pagiging makabayan 
				at makabansa.",
				"rizal7" : "Bago ko subukan ang iyong kaalaman, kailangan mo munang maghanap ng 
				dalawang mahahalagang bagay sa paligid ng dambanang ito:
		Isang Quill Pen – simbolo ng mga sinulat ni Rizal na gumising sa bayan.
		Isang Aklat – kumakatawan sa kanyang pagkauhaw sa kaalaman at 
		edukasyon.",
				"rizal8" : "Dalhin mo sa akin ang mga ito, at saka mo pa lamang maaring sagutin ang 
				katanungan para sa pagsusulit. Kumpletuhin ang misyon na ito, at maaari 
				kang magpatuloy sa iyong paglalakbay sa isa 
				pang palatandaan.",
				"rizal9" : "Magaling! Nahanap mo ang mga bagay na kumakatawan sa isip at diwa ni 
				Rizal.Ngayon, tingnan natin kung talagang may natutunan ka tungkol 
				sa lugar na ito.",
				"rizal10" : "Tanong 1: Sino ang sumulat ng Noli Me Tangere at El Filibusterismo?

		A. Andres Bonifacio
		B. Emilio Aguinaldo
		C. José Rizal 
		",
				"rizal11" : "Tanong 2: Ano ang nangyari sa orihinal na Bahay ni Rizal noong 
				Ikalawang Digmaang Pandaigdig?
				
		A. Nakaligtas ito nang hindi nagalaw
		B. Ito ay nawasak 
		C. Inilipat ito sa ibang bayan
		",
				"rizal12" : "Napakagaling! Napatunayan mo na ang iyong kaalaman. Maaari mo na 
				ngayong ipagpatuloy ang iyong paglalakbay patungo sa 
				St. John the baptist church.",
				"rizal13" : "Hmm...hindi masyado, Isip ka ulit ng mabuti mang-aaral. Ang istorya ni Rizal 
				ay mas karapat-dapat maalala ng tama, ulitin mo ulit.",
				"book1" : "Natuklasan mo ang isang Aklat — Ito ay simbolo ng pagmamahal 
				ni Rizal sa pag-aaral.",
				"book2" : "Mula sa murang edad, si Rizal ay isang dedikadong estudyante.",
				"book3" : "Nag-aral siya sa Maynila sa Ateneo Municipal at kalaunan sa 
				Europa, kung saan siya nag-master ng maraming wika at 
				naging isang doktor, manunulat, 
				at siyentipiko.",
				"book4" : "Ang aklat na ito ay kumakatawan sa kanyang paniniwala na 
				ang edukasyon ang susi sa pag-angat 
				ng bansa.",
				"pencil1" : "Nakakita ka ng isang lumang Quill Pen. Ito ay kumakatawan sa 
				makapangyarihang mga sinulat ni Rizal na gumising sa diwa ng 
				Pilipino.",
				"pencil2" : "Sa pamamagitan ng kanyang mga nobelang Noli Me Tángere (1887) 
				at El Filibusterismo (1891), inilantad niya ang mga 
				kawalang-katarungan ng pamumuno ng 
				mga Espanyol.",
				"pencil3" : "Hindi tulad ng ibang mga rebolusyonaryo, pinili ni Rizal ang 
				panulat kaysa sa espada — nagbibigay-inspirasyon na 
				Ipaglaban ng mga Pilipino ang kalayaan sa 
				pamamagitan ng kaalaman at pagkakaisa.",
		
#CHURCH_SCENE
	"church1" : "Maligayang pagdating, anak, sa St. John the Baptist Parish Church dito 
	sa Calamba. Naandito ka sa loob ngayon at nakikita ang pagkakaroon ng 
	pananampalataya,kahirapan, pagbabago, at paghubog ng 
	isang tao.",
			"church2" : "Nakikita kong dumating ka na may taos-pusong loob na 
			sumasampalataya. Hayaan mong ikuwento ko sa iyo ang mga 
			kuwento, upang maunawaan mo kung bakit ang lugar 
			na ito ay higit pa sa bato at kahoy lamang.",
			"church3" : "Ang parokyang ito ay pormal na itinatag noong 1779, nang ang Calamba ay 
			naging malaya mula sa ang parokyal na simbahan ng Cabuyao. Ang mga 
			misyonerong Jesuit ay naunang nakakuha ng lupa dito, na tinatawag 
			na Hacienda de San Juan, para sa mga misyon. ",
			"church4" : "Noong 1859, isang simbahang bato ang itinayo sa istilong Baroque. Ngunit 
			noong Ikalawang Digmaang Pandaigdig, noong 1945, ang istrukturang ito 
			ay nawasak. Nasunog ang altar noong 1862, ngunit agad naman itinayong 
			muli noong panahong iyon. ",
			"church5" : "Pagkatapos ng digmaan, ang pagpapanumbalik ay pinangunahan ni 
			Padre Eliseo Dimaculangan. Gayundin, ang batang José Rizal, ang ating 
			pambansang bayani, ay bininyagan dito noong Hunyo 22, 1861, ni 
			Fr. Rufino Collantes; at ang kanyang ninong 
			ay si Fr. PEDRO CASANAS. ",
			"church6" : "Ang baptistery, kung saan naganap ang sagradong gawaing iyon, ay 
			kinikilala bilang National Historical Landmark. Bagaman maraming orihinal
			na rekord ang nawala nasunog ang mga kanonikal na aklat noong 1862, 
			karamihan sa orihinal ay nawasak sa altar ngunit naibalik 
			ang mga ito o pinalitan ng bago...",
			"church7" : "Sa loob na ito ay makikita pa rin ang mga stained-glass windows 
			na naglalarawan ng mga santo, ang pitong sakramento, at sa pasukan ay 
			dalawang stained glass: Saint Dominic at San Lorenzo Ruiz. Nagkaroon 
			din ng isang hardin na tinatawag na Halamanan ng Getsemani, na may mga 
			Istasyon ng Krus at a “Well of Repentance” (Balon ng Pagbabalik Loob). ",
			"church8" : "Ang lahat ng kasaysayang ito ay nagpapatotoo sa ating 
			pananampalataya at nagpapaalala sa atin ng ating pinagmulan, ating 
			mga pakikibaka, at sanggahan nating 
			mga sumasampalataya.",
			"church9" : "Upang mas mapanatili pa natin ang mga alaala ukol sa mga record ng 
			bautismong ating pambansang bayani, ikaw ay binibigyan kong masagutan ang isang 
			puzzle,na kung saan ay kailangan mo makuha ang tamang button para lumabas 
			ang master registry na naglalaman ng mga ginanap na binyag dito.Ang 
			aklat na ito ay ipapamana ko sa iyo at kapag di mo ito 
			nasagutan ikaw ay uulit-ulit sa simula.",
			
			#Puzzle_Part
			"masterreg1" : "Isang sinaunang aklat ng talaan mula sa St. John the Baptist Church. 
			Taglay nito ang mga pangalan ng mga henerasyong nabautismuhan dito, kabilang ang 
			kay José Rizal noong 1861. Bagama't may peklat ng apoy at panahon, nananatili itong 
			simbolo ng pananampalataya, alaala, at ang matibay na diwa ng pamayanan.",
		
		
#CCC_INSIDE
		"ccc1" : "Welcome, Scholars! Naandito ka ngayon sa loob ng City College of 
		Calamba...",
		"ccc2" : "pero alam mo bang ang lugar na ito ay dating Old Municipal Building 
		ng Calamba?",
		"ccc3" : "Noong una, ito ang sentro ng pamamahala, kung saan nagtipon ang 
		mga pinuno ng bayan at gumawa ng mahahalagang desisyon para 
		sa komunidad.",
		"ccc4" : "Ngayon, hindi lang ito isang paalala ng ating civic past",
		"ccc5" : "kundi bilang isang lugar din ng pag-aaral—kung saan hinuhubog 
		ng mga kabataang Calambeño ang kanilang kinabukasan.",
		"ccc6" : "Magkahawak-kamay na naglalakad ang kasaysayan at edukasyon 
		sa mismong gusaling ito.",
		"ccc7" : "Tingnan natin kung nakikinig ka nang mabuti. Sagutin nang tama ang aking mga tanong, at ikaw ay makakapasa
		dito sa City College of Calamba!",
		"ccc_q1": "Tanong 1:\nAno ang dating gamit ng gusaling kinaroroonan ng City College of 
		Calamba?\nA. Palengke\nB. Munisipyo\nC. Simbahan",
		"ccc_q2": "Tanong 2:\nAno naman ang gamit ng gusaling ito ngayon?\n\nA. Museo\nB. Ospital ng Unibersidad\nC. City College of Calamba",
		"ccc_correct1": "Tama! Ang gusaling ito noon ay nagsilbing munisipyo.",
		"ccc_incorrect1": "Mali...Subukang muli!",
		"ccc_correct2": "Mahusay! Sa ngayon, ang makasaysayang gusaling ito ay ang City 
		College of Calamba.\nMaaari ka nang bumalik sa mapa upang pumunta sa credits scene.",
		"ccc_incorrect2": "Mali...Subukang muli!",
		
		
#ASSESSMENT_SCENE
		"assessment1" : "Na-explore mo na ang mga kayamanan ng Calamba 
		— mula sa Giant Claypot, sa payak na tahanan 
		ni Rizal, hanggang sa lumang simbahan sa plaza.",
		"assessment2" : "Bago ka pumasok sa City College of Calamba, 
		tingnan natin kung gaano kalalim ang pagkakaintindi mo 
		sa mga kuwento sa likod ng bawat lugar.",
		"assessment3" : "Mag-isip nang mabuti. Ang mga sagot ay nakatago 
		sa mga nakita at natutunan mo na.",
		"assessment4" : "Sa opisyal na selyo ng Calamba, may nakalagay na palayok 
		(banga).Nakita mo na ito nang maraming beses — nakatayo 
		nang buong pagmamalaki sa plasa ng bayan. Ngunit anong mas 
		malalim na kahulugan ang taglay nito?

		A. Ito ay kumakatawan lamang sa mga sinaunang gamit ng mga tao.
		B. Sumisimbolo ito sa pagkamalikhain at kabuhayan ng Calamba, na 
		nagpapakita kung paano ang mga simpleng bagay ay maaaring 
		kumatawan sa pagkakakilanlan.
		C. Isa lamang itong palamuti noong panahon ng Espanyol.",
		"assessment5" : "Sa Rizal Shrine, bawat sulok ay nagpapakita ng 
		paraan ng pagpapalaki sa batang José Rizal. Lumakad ka sa mga 
		silid na iyon — ang kusina, ang silid-aralan, ang kapilya. 
		Anong aral ang itinuturo sa atin ng kanyang tahanan?

		A. Na ang kasipagan, pananampalataya, at disiplina ang nagtayo ng pundasyon 
		ng kanyang kadakilaan.
		B. Na nabuhay siya nang marangya at puno ng mga katulong at kaginhawaan.
		C. Na ang kanyang mga tagumpay ay nagmula lamang sa talento.",
		"assessment6" : "Pambihira! Hindi mo lang naalala ang mga impormasyon 
		— naintindihan mo ang puso ng pamana ng Calamba. Maaari ka nang 
		pumasok sa City College of Calamba.",
		"assessment7" : "Nakita mo ang mga lugar, ngunit hindi pa ganap na 
		tumatagos sa iyong puso ang kanilang kahulugan. 
		Pag-isipan at balikan mong muli ang mga kuwentong 
		sinabi sa iyo ng bawat palatandaan, pagkatapos 
		ay bumalik ka.",

#TUTORIAL_KALANBANGA
		"tips" : "MGA PAALALA (TIPS)",
		"t_banga2" : "Ikaw ito, ang manlalaro.",
		"t_banga3" : "Ang simbolo na ito 
		ay nagpapahiwatig ng 
		pakikipag-usap at 
		misyon",
		"t_banga4" : "Gamitin ang button na ito kung
		pipiliin mo ang A sa isang tanong",
		"t_banga5" : "Gamitin ang button na ito kung
		pipiliin mo ang B sa isang tanong",
		"t_banga6" : "Gamitin ang button na ito kung
		pipiliin mo ang C sa isang tanong",
		"t_banga7" : "Gamitin ang button na ito para 
		sa susunod at sa 
		pakikipag-ugnayan 
		sa mga bagay.",

#TUTORIAL_RIZAL
		"t_rizal1" : "Maaari mong pindutin ang 
		button na ito kung gusto 
		mong makita ang opsyon.",
		"t_rizal2" : "Ang simbolo na ito ay 
		nagpapahiwatig para sa 
		iyong misyon.",
		"t_rizal3" : "Maaari mo itong tapakan
		upang mag-teleport.",
		
#TUTORIAL_CHURCH
		"t_church1" : "Maaari mo itong tapakan para 
		sa pagsagot sa puzzle.",
		"t_church2" : "GABAY SA PUZZLE",
		"t_church3" : "Ang kaliwang button ay katumbas ng 1.
		Ang gitnang button ay katumbas ng 2.
		Ang kanang button ay katumbas ng 3.
		Maaari itong gamitin sa pagsagot sa 
		puzzle quest.",
		"t_church4" : "Puwede kang tumapak ng tatlong (3) beses sa 
		isang button.",
		"t_church5" : "Basahing mabuti ang diyalogo sa father NPC 
		at may nakasulat na MALAKING Letra para 
		sa isang clue.",
		

#TUTORIAL_CCC
		"t_ccc1" : "Ang City College of Calamba ay itinatag noong 2006 
		— sa taon ding iyon ipinagdiwang ang ika-145 anibersaryo ng 
		kapanganakan ni José Rizal!",
		"t_ccc2" : "Ang CCC ay itinayo upang magbigay ng abot-kaya 
		at de-kalidad na edukasyon sa mga Calambeñong may 
		malalaking pangarap ngunit hindi kayang mag-aral 
		sa mamahaling mga paaralan.",
		"t_ccc3" : "Ang mga pangunahing halaga (core values) ng kolehiyo 
		ay binabaybay sa RIZAL — Resilient (Matatag), Integrity-driven 
		(Hinihimok ng Integridad), Zealous (Masigasig), Adaptable 
		(Madaling Maka-angkop), 
		at Lifelong Learner (Panghabambuhay na Mag-aaral)!",
		"t_ccc4" : "Ang CCC ay nakatayo sa lumang lugar ng Munisipyo ng Calamba, 
		pinapanatili ang bahagi ng kasaysayan ng lungsod habang 
		hinuhubog ang kinabukasan nito.",
		"t_ccc5" : "Ang CCC ay CHED-recognized at ALCUCOA-accredited, sinisiguro 
		ang de-kalidad na edukasyon na umaabot sa mga 
		pambansang pamantayan.",

		"trivia" : "MGA TRIVIA AT KATOTOHANAN",
		"dyk" : "Alam mo ba?💡",
		"facts" : "MGA KATOTOHANAN",

#CONTROL_SYSTEM
		"control1" : "Gamitin para bumaba",
		"control2" : "Gamitin para lumipat sa kaliwa",
		"control3" : "Gamitin para tumaas",
		"control4" : "Gamitin para lumipat sa kanan",
		
		"map_instruction_complete": "Natapos mo ang tutorial sa mapa! Maaari ka nang pumunta
		sa kalanbanga",
		"quest_already_finished": "Natapos mo na ang quest na ito!",
		"need_finish_kalanbanga": "Tapusin mo muna ang KalanBanga!",
		"need_finish_rizal": "Tapusin mo muna ang Rizal Shrine!",
		"need_finish_church": "Tapusin mo muna ang simbahan!",

		"go_map" : "Bumalik sa mapa",
		
		"cong1" : "Maligayang bati! sa pagtapos ng laro.",
		"cong2" : "Gusto mo bang umulit ulit?",
		"cong3" : "Sigurado ka bang gusto mong umalis?",
		"cong4" : "Salamat sa paglalaro!",
		
		
		"choice1" : "",
		"choice2" : "",
		"choice3" : "",
		"choice4" : "",
		"choice5" : "",
		"npcchoice1" : "",
		"npcchoice2" : "",
		"npcchoice3" : "",
		"npcchoice4" : "",
		"npcchoice5" : "",
		"npcchoice6" : "",
		
		"quest_tourguide": "Misyon: Makipag-usap sa tourguide",
		"quest_collect": "Misyon: Hanapin at kolektahin ang mga aklat at lapis",
		"quest_return": "Misyon: Bumalik sa tourguide",
		"quest_complete_rizal": "Misyon Natapos: Rizal Shrine",
		"collected_label_book" : "Nakolekta na ang Aklat!",
		"collected_label_pencil" : "Nakolekta na ang Lapis!",
		
		
		"quest_ccc1" : "Misyon : Kausapin ang professor",
		"quest_ccc2" : "Misyon : Sagutan ang pagsusulit",
		"quest_ccc3" : "Misyon Natapos : CCC",
		
		"banga1" : "Misyon : Bumili sa nagtitinda",
		"banga2" : "Misyon : Maghanap ng pera",
		"banga3" : "Misyon : Bumalik sa nagtitinda",
		"banga4" : "Misyon Natapos : KalanBanga!",
		
		"quest_church1" : "Misyon : Kausapin si Pader",
		"quest_church2" : "Misyon : Sagutan ang palaisipan sa pamamagitan
ng pagtapak ng tatlong (3) beses sa button icon,
meron ka lamang na tatlong (3) ulit.\n
Clue : Ilan ang ninong ni Rizal?",
		"quest_church3" : "Misyon : Kuhanin ang bagay",
		"quest_church4" : "Misyon Natapos : Simbahan!",
		"masstereg" : "Nakolekta na ang Master Registry",
		"map" : "Misyon : Pumunta sa KalanBanga",
		
		
		"portal" : "Misyon : Natapos ang misyon, pumunta sa portal",
		
		
		"all_quests_complete": "Natapos na ang lahat ng quests! 
		Pupunta na sa huling eksena sa sandaling ito...",

	}
}
func set_language(lang: String):
	if current_language == lang:
		return
	current_language = lang
	emit_signal("language_changed", lang)

func get_text(key: String) -> String:
	return translations.get(current_language, {}).get(key, key)
