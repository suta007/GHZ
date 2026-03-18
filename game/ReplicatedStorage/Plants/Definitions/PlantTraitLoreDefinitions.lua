local v1 = {
	["Tomato"] = {
		["Name"] = "Tomato",
		["Description"] = "<i>Solanum lycopersicum</i>, more commonly known as the tomato, is a plant whose fruit is an edible berry which is used as a vegetable. Tomatoes are a key component in many cuisines around the world.\n<i>Knowledge is knowing a tomato is a fruit; wisdom is not putting it in a fruit salad</i>",
		["Attributes"] = { "Berry", "Fruit", "Vegetable" }
	},
	["Potato"] = {
		["Name"] = "Potato",
		["Description"] = "<i>Solanum tuberosum</i>, more commonly known as the potato, is a starchy tuberous vegetable native to the Americas considered a staple food in many parts of the world. Potatoes are underground tuber portion of the <i>S. tuberosum</i> plant.\n<i>Potatoes and tomatoes both belong to the genus Solanum, and potato plants in real life produce small toxic fruit!</i>",
		["Attributes"] = { "Vegetable" }
	},
	["Plum"] = {
		["Name"] = "Plum",
		["Description"] = "<i>Prunus domestica</i>, commonly known simply as the plum, is a small deciduous tree in the rose family that produces juicy, sweet stone fruits prized around the world. Plums can be eaten fresh, used in jams and preserves, or dried to make prunes, and they come in a variety of colors from deep purple to bright yellow when ripe. Their early spring blossoms attract pollinators, and the fruits that follow are enjoyed by wildlife and people alike.\n<i>Plums are likely to have been one of the first fruits to be domesticated by humans.</i> ",
		["Attributes"] = { "Fruit", "Stone Fruit" }
	},
	["Cherry"] = {
		["Name"] = "Cherry",
		["Description"] = "<i>Prunus avium</i> (and its close relatives), commonly known as the cherry, is a stone fruit from trees in the rose family that produces small, round fruits ranging in color from bright yellow through deep red and nearly black when ripe. Sweet cherries are often enjoyed fresh or preserved, while tart varieties are prized for sauces, jams, and pies. The trees bloom with clusters of delicate colorful blossoms each spring.\n<i>Plums and cherries both belong to the same genus Prunus!</i>",
		["Attributes"] = { "Fruit", "Stone Fruit" }
	},
	["Pomaganit"] = {
		["Name"] = "Pomaganit",
		["Description"] = "<i>pomaganita</i>, the pomaganit is an Incredible.\n<i>pomaganit or ymir-ganit?</i>",
		["Attributes"] = { "Berry", "Fruit" }
	},
	["Strawberry"] = {
		["Name"] = "Strawberry",
		["Description"] = "<i>Fragaria \195\151 ananassa</i>, the garden strawberry, is a widely grown hybrid species of the genus Fragaria. It is cultivated worldwide for its fruit, which is appreciated for its characteristic aroma, bright red color, and sweetness. Despite its name, the strawberry is not a botanical berry but an \'accessory fruit,\' as the fleshy part is derived from the flower\'s receptacle rather than the ovaries.\n<i>Strawberries are the only fruit with their seeds on the outside\226\128\148the average strawberry has about 200 of them!</i>",
		["Attributes"] = { "Berry", "Fruit" }
	},
	["Banana"] = {
		["Name"] = "Banana",
		["Description"] = "<i>Musa acuminata</i> is a large herbaceous flowering plant that produces the world\'s most recognizable tropical fruit. Though they grow tall, bananas are not trees but giant herbs, and the fruit itself is botanically classified as a berry.\n<i>Because they are genetically identical, a single disease could potentially wipe out the most common variety of banana worldwide!</i>",
		["Attributes"] = { "" }
	},
	["Beetroot"] = {
		["Name"] = "Beetroot",
		["Description"] = "<i>Beta vulgaris</i> is a taproot vegetable known for its deep purple hue and earthy flavor. Beets are highly versatile, used for food coloring, sugar production, and even medicinal purposes throughout history.\n<i>The Romans used beetroot as an aphrodisiac, and scientists have found they contain high amounts of boron, which relates to hormone production.</i>",
		["Attributes"] = { "" }
	},
	["Carrot"] = {
		["Name"] = "Carrot",
		["Description"] = "<i>Daucus carota</i> is a root vegetable typically orange in color, though purple, black, red, white, and yellow cultivars exist. They are the domesticated form of the wild carrot, native to Europe and Southwestern Asia.\n<i>Carrots weren\'t always orange; they were originally purple or white. The orange carrot was developed in the Netherlands as a tribute to the House of Orange!</i>",
		["Attributes"] = { "" }
	},
	["Corn"] = {
		["Name"] = "Corn",
		["Description"] = "<i>Zea mays</i>, also known as maize, is a cereal grain first domesticated by indigenous peoples in southern Mexico about 10,000 years ago. The leafy stalk produces pollen inflorescences and separate ovuliferous inflorescences called ears.\n<i>An ear of corn always has an even number of rows, usually 16.</i>",
		["Attributes"] = { "" }
	},
	["RotoBird"] = {
		["Name"] = "RotoBird",
		["Description"] = "<i>Gallus domesticus rotovalis</i> is a peculiar avian creature often found nesting near garden plots. While technically a bird, its sedentary lifestyle and tendency to \'grow\' in one spot have led many amateur gardeners to treat it as a high-maintenance vegetable.\n<i>Is it a bird that looks like a plant, or a plant that learned to cluck? The scientific community is still arguing, but the eggs are delicious either way.</i>",
		["Attributes"] = { "" }
	},
	["Mushroom"] = {
		["Name"] = "Mushroom",
		["Description"] = "<i>Agaricus bisporus</i> is the fleshy, spore-bearing fruiting body of a fungus. Unlike plants, mushrooms do not require sunlight to grow, instead drawing nutrients from decomposing organic matter through a vast underground network called mycelium.\n<i>Mushrooms are more closely related to humans than they are to plants!</i>",
		["Attributes"] = { "" }
	},
	["Rose"] = {
		["Name"] = "Rose",
		["Description"] = "<i>Rosa</i> is a woody perennial flowering plant of the genus Rosa, in the family Rosaceae. They are best known for their fragrant blooms and thorny stems, serving as ancient symbols of love and beauty across nearly every culture.\n<i>Rose petals are actually edible and can be used to make tea, jam, or flavoring for sweets.</i>",
		["Attributes"] = { "" }
	},
	["Onion"] = {
		["Name"] = "Onion",
		["Description"] = "<i>Allium cepa</i> is a bulbous vegetable that grows in layers. It is a staple in almost every culinary tradition due to its pungent aroma and flavor. When cut, it releases a gas that reacts with the water in your eyes to form a mild sulfuric acid.\n<i>Ancient Egyptians worshipped onions, believing their spherical shape and concentric rings symbolized eternal life.</i>",
		["Attributes"] = { "" }
	},
	["Dawnfruit"] = {
		["Name"] = "Dawnfruit",
		["Description"] = "<i>Aurora fructus</i> is a rare botanical wonder featuring glowing, sun-like spheres atop stems as dark as midnight. It is said to absorb the first rays of light at daybreak, storing that energy within its translucent skin.\n<i>Walking through a field of Dawnfruit at night is like walking among fallen stars, though the stems remain invisible in the dark.</i>",
		["Attributes"] = { "" }
	},
	["Cabbage"] = {
		["Name"] = "Cabbage",
		["Description"] = "<i>Brassica oleracea</i> is a leafy green, red, or white biennial plant grown as an annual vegetable for its dense-leaved heads. It is a hardy crop that thrives in cool weather and can be stored for long periods.\n<i>Cabbage is the ancestor of broccoli, cauliflower, kale, and brussels sprouts; they are all actually the same species of plant!</i>",
		["Attributes"] = { "" }
	},
	["Wheat"] = {
		["Name"] = "Wheat",
		["Description"] = "<i>Triticum aestivum</i> is a grass widely cultivated for its seed, a cereal grain which is a worldwide staple food. It is the primary ingredient in flour, which forms the foundation of bread, pasta, and pastries.\n<i>Wheat is grown on more land area than any other food crop in the world.</i>",
		["Attributes"] = { "" }
	},
	["Apple"] = {
		["Name"] = "Apple",
		["Description"] = "<i>Malus domestica</i> is a pome fruit produced by the apple tree, one of the most widely cultivated tree fruits in the world. Apples have been grown for thousands of years in Asia and Europe and were brought to North America by European colonists.\n<i>An apple a day keeps the doctor away, but only if you have good aim!</i>",
		["Attributes"] = { "" }
	},
	["Dandelion"] = {
		["Name"] = "Dandelion",
		["Description"] = "<i>Taraxacum officinale</i> is a hardy flowering plant commonly found in fields and lawns. Known for its bright yellow flowers and fluffy seed heads, it thrives in disturbed soils and spreads easily by wind.\n<i>Every part of the dandelion is edible, though most people only notice it when it invades their lawn.</i>",
		["Attributes"] = {}
	},
	["Sunpetal"] = {
		["Name"] = "Sunpetal",
		["Description"] = "<i>Heliopetala luminis</i> is a radiant flowering plant whose petals subtly track the sun throughout the day. Its warm glow has made it a symbol of optimism and renewal in folklore.\n<i>Gardeners say Sunpetals bloom brightest when planted where hope once faded.</i>",
		["Attributes"] = {}
	},
	["Bellpepper"] = {
		["Name"] = "Bellpepper",
		["Description"] = "<i>Capsicum annuum</i> is a mild pepper cultivar valued for its crisp texture and sweet flavor. Unlike its spicy relatives, it contains no capsaicin and comes in a range of colors as it ripens.\n<i>Green, yellow, orange, and red bell peppers are all the same fruit\226\128\148just at different stages of maturity.</i>",
		["Attributes"] = {}
	},
	["Goldenberry"] = {
		["Name"] = "Goldenberry",
		["Description"] = "<i>Physalis peruviana</i> seems to be an unassuming, leafy plant on a first glance. Its leaves, however, have a miraculous golden, metallic quality to them, earning the plant its name. The leaves aren\'t actually made of gold, but have a small layer of sweet resin coating them.\n<i>Goldenberries are incredibly sweet, encouraging their usage in all kinds of desserts around the world.</i>",
		["Attributes"] = {}
	},
	["Amberpine"] = {
		["Name"] = "Amberpine",
		["Description"] = "<i>Pinus succinum</i> is a resin-rich evergreen, or rather ever-orange tree known for producing hardened sap resembling amber. Its wood carries a faint honeyed scent when cut.\n<i>Some believe Amberpine resin preserves memories as well as insects.</i>",
		["Attributes"] = {}
	},
	["Birch"] = {
		["Name"] = "Birch",
		["Description"] = "<i>Betula</i> is a genus of slender, fast-growing trees recognized by their distinctive peeling bark. Birch trees are pioneers, often among the first to colonize cleared land.\n<i>Birch bark was once used as paper, roofing, and even canoes.</i>",
		["Attributes"] = {}
	},
	["Emberwood"] = {
		["Name"] = "Emberwood",
		["Description"] = "<i>Ignilignum ruber</i> is a rare tree whose inner wood radiates an intense heat gathered from the sun. It is prized for forging tools and sustaining long-lasting embers.\n<i>Legends say Emberwood never truly goes cold.</i>",
		["Attributes"] = {}
	},
	["Orange"] = {
		["Name"] = "Orange",
		["Description"] = "<i>Citrus \195\151 sinensis</i> is a sweet citrus fruit cultivated worldwide for its juicy flesh and fragrant peel. Oranges are a major source of vitamin C.\n<i>Orange trees can bear flowers and fruit at the same time.</i>",
		["Attributes"] = {}
	},
	["Dawnblossom"] = {
		["Name"] = "Dawnblossom",
		["Description"] = "<i>Aurora florens</i> is a delicate flowering tree that releases light to attract pollinators to its flowers. Its wood has incredible durability, labelling it as a staple in many construction projects. Over time, it has become a rare botanical delicacy due to overharvesting.\n<i>Dawnblossoms are said to bloom where the night gives up.</i>",
		["Attributes"] = {}
	},
	["Olive"] = {
		["Name"] = "Olive",
		["Description"] = "<i>Olea europaea</i> is a slow-growing evergreen tree cultivated for its fruit and oil for thousands of years. Olive trees are symbols of peace, endurance, and longevity.\n<i>Some olive trees still producing fruit today are over a thousand years old.</i>",
		["Attributes"] = {}
	},
	["Biohazard Melon"] = {
		["Name"] = "Biohazard Melon",
		["Description"] = "<i>Citrullus toxica</i> is a volatile melon variety rumored to have developed in contaminated soils. Its rind bears unnatural mottled patterns, and the flesh glows faintly under low light.\n<i>It smells sweet, tastes sweeter, and is absolutely not FDA approved.</i>",
		["Attributes"] = { "" }
	},
	["Lablush Berry"] = {
		["Name"] = "Lablush Berry",
		["Description"] = "<i>Rubra experimentalis</i> is a laboratory-cultivated berry bred for intense color and amplified sweetness. Its vibrant pink juice stains everything it touches.\n<i>Originally engineered to be the \"perfect\" berry, it somehow became slightly self-aware.</i>",
		["Attributes"] = { "" }
	},
	["Starvine"] = {
		["Name"] = "Starvine",
		["Description"] = "<i>Astra vitis</i> is a small tree whose small star-shaped fruits shimmer faintly, especially visible at night. Its leaves have a unique blue color that has attracted interest in its usage as a natural dye.\n<i>Some say the fruit glows brighter when someone nearby makes a wish.</i>",
		["Attributes"] = { "" }
	},
	["Radiant Petal"] = {
		["Name"] = "Radiant Petal",
		["Description"] = "<i>Luminflora aurea</i> is a flowering plant known for a stem that emits a bright fuschia light. It is often planted in ceremonial gardens and along twilight pathways.\n<i>Radiant Petals never wilt in the presence of kindness. Scientists are still testing this theory.</i>",
		["Attributes"] = { "" }
	},
	["Octobranch"] = {
		["Name"] = "Octobranch",
		["Description"] = "<i>Arbor octavus</i> is an unusual tree that used to grow with eight primary limbs in near-perfect symmetry. Over time, however, it has been cultivated to have fewer branches, though its branching pattern still makes it instantly recognizable from afar.\n<i>Lumberjacks dislike Octobranch. It dislikes them back.</i>",
		["Attributes"] = { "" }
	},
	["Bamboo"] = {
		["Name"] = "Bamboo",
		["Description"] = "<i>Bambusoideae</i> is a fast-growing grass species known for its hollow stems and remarkable strength. Some varieties can grow several feet in a single day.\n<i>Bamboo is technically grass, but it builds houses.</i>",
		["Attributes"] = { "" }
	},
	["Mango"] = {
		["Name"] = "Mango",
		["Description"] = "<i>Mangifera indica</i> is a tropical stone fruit prized for its juicy, fragrant flesh. Mango trees can live for decades and bear hundreds of fruits in a single season.\n<i>The mango is often called the \"king of fruits\" in many parts of the world.</i>",
		["Attributes"] = { "" }
	},
	["Lostlight"] = {
		["Name"] = "Lostlight",
		["Description"] = "<i>Lumen evanescentis</i> is a pale, short-lived plant often found growing in overlooked corners and shaded edges. Its faintly luminous stems flicker in low light before dimming entirely at maturity.\n<i>Nobody remembers planting them. They just show up.</i>",
		["Attributes"] = {}
	},
	["Twisted Sunflower"] = {
		["Name"] = "Twisted Sunflower",
		["Description"] = "<i>Helianthus convolutus</i> is a variant of the common sunflower whose stem curves wildly. It still tracks the sun, but seems to disagree with it.\n<i>Botanists describe it as \'architecturally confrontational.\'</i>",
		["Attributes"] = {}
	},
	["Roundmelon"] = {
		["Name"] = "Roundmelon",
		["Description"] = "<i>Cucumis orbis</i> is an almost perfectly spherical melon cultivar prized more for its geometric novelty than its flavour. It rolls off tables, out of baskets, and occasionally down hills.\n<i>The taste is fine. The shape is the point.</i>",
		["Attributes"] = {}
	},
	["Glowcorn"] = {
		["Name"] = "Glowcorn",
		["Description"] = "<i>Zea luminosa</i> is a bioluminescent maize variant whose kernels emit a faint pink glow. It is unclear whether this trait serves any ecological purpose whatsoever.\n<i>Makes for a terrible nightlight but an excellent conversation starter.</i>",
		["Attributes"] = {}
	},
	["Inferno Pepper"] = {
		["Name"] = "Inferno Pepper",
		["Description"] = "<i>Capsicum infernum</i> is an intensely pungent pepper cultivar that produces fruit hot enough to make seasoned chefs reconsider their career choices. The plant itself seems unbothered by its own potency.\n<i>Wearing gloves is recommended. Wearing two pairs is smarter.</i>",
		["Attributes"] = {}
	},
	["Firefern"] = {
		["Name"] = "Firefern",
		["Description"] = "<i>Pteridium ignifer</i> is a heat-tolerant fern whose fronds flush a deep ember-red at maturity. It thrives in warm, dry conditions that would wilt most other ferns entirely.\n<i>It doesn\'t actually catch fire. Probably.</i>",
		["Attributes"] = {}
	},
	["Glowflower"] = {
		["Name"] = "Glowflower",
		["Description"] = "<i>Luminflora phosphora</i> is a flowering plant whose blooms produce a steady, soft light through a poorly understood biochemical process. Researchers have been studying it for years and remain politely confused.\n<i>Useful for finding your way in the dark. Less useful for sleeping next to.</i>",
		["Attributes"] = {}
	},
	["Titan Bloom"] = {
		["Name"] = "Titan Bloom",
		["Description"] = "<i>Flora colosseum</i> is an oversized flowering plant that produces blooms disproportionately large for its stem. How it supports the weight is a question it answers with sheer stubbornness.\n<i>It grows big because nobody told it not to.</i>",
		["Attributes"] = {}
	},
	["Bluerose"] = {
		["Name"] = "Bluerose",
		["Description"] = "<i>Roasaceae caerulea</i> is a nearly extinct species of vascular plant known for its large, bulky stalk that seems more akin to a tree trunk than a stem. When robloxians arrived to it\'s origin island, they gathered bulk amounts of it due to it\'s beauty, leading to it\'s quick decline in population over the past decades.\n<i>The botanical beauty of a lost decade.</i>",
		["Attributes"] = {}
	},
	["Glowvein"] = {
		["Name"] = "Glowvein",
		["Description"] = "<i>Vitis luminaris</i> is a tall, sturdy tree with an equally tall fruit that stumps almost anyone. The fruit is a lengthy, skinny gourd that glows with a warm yellow light. Surrounding it, 4-5 skinny rings are suspended in the air. This complex arrangement seems to have no biological benefit, though active study continues.\n<i>The Glowvein is unlike any other plant in the world, a shining example of the absurdity of nature.</i>",
		["Attributes"] = {}
	},
	["Lumenbark"] = {
		["Name"] = "Lumenbark",
		["Description"] = "<i>Quercus luminescens</i> is an ancient tree species that has been found in fossil records dating back to nearly 200 million years ago. It is a large, slow-growing oak tree mutated by Cthulhu to have a striking luminescence eminating from its fruit. It has a very directed light that shines straight down to the soil below. \n<i>If there were a forest of Lumenbark, it would be akin to walking under the light of a million streetlights.</i>",
		["Atrributes"] = {}
	},
	["Lilystalk"] = {
		["Name"] = "Lilystalk",
		["Description"] = "<i>Arum spathiphyllum</i> is a large flower that grows a long, thick stalk from its center. Many smaller flowers grow from the sturdy, wood \'vine\' like structure that curls around the stalk. Lilystalk was specifically domesticated in this way to be used as a decorative plant for celebrations.\n<i>Some say seeing a Lilystalk flower is mark of good fortune.</i>",
		["Atrributes"] = {}
	},
	["Pineapple"] = {
		["Name"] = "Pineapple",
		["Description"] = "<i>Ananas comosus</i> is a large, bulbous fruit that grows on a thick, woody stalk in real life. The fruit is a bright yellow color and has a thick, fibrous rind. The fruit first develops as a beautiful, vibrant red flower, before developing into the fruit we know and love. \n<i>Pineapples belong on pizza. Fight me.</i>",
		["Atrributes"] = {}
	},
	["Watermelon"] = {
		["Name"] = "Watermelon",
		["Description"] = "<i>Citrullus lanatus</i> is a large, bulbous fruit that grows on a trailing vine-like plant in real life. The fruit has a bright green rind with a red, sweet, fleshy interior. It is often seen in the summer months and is portrayed as a symbol of summer and relaxation. \n<i>The watermelon is around 91% water.</i>",
		["Atrributes"] = {}
	}
}
local v2 = {}
for v3, v4 in pairs(v1) do
	if v4.Attributes then
		for _, v5 in ipairs(v4.Attributes) do
			if v5 ~= "" then
				if not v2[v5] then
					v2[v5] = {}
				end
				local v6 = v2[v5]
				table.insert(v6, v3)
			end
		end
	end
end
return {
	["Info"] = v1,
	["ByAttribute"] = v2
}