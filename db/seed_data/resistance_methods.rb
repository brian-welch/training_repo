def resistance_methods_list
	return [
		{name: "Barbell", instructions: "Record the total load, including the bar's weight.", unilateral: false},
		{name: "Bodyweight", instructions: "As simple as it comes; the app will use your current bodyweight automatically", unilateral: false, bodyweight: true},
		{name: "Bodyweight +Weight", instructions: "Record only the added free weight used; the app will add your current bodyweight automatically", unilateral: false, bodyweight: true},
		{name: "cable", instructions: "When there is only one cable being utilized to move one weight load.", unilateral: false, bodyweight: false},
		{name: "Crossover", instructions: "When each arm is utilizing a seperate cable to move 2 seperate weight loads. Record the weight on only one of the weight stacks. 30 on 2 stacks should be logged as 30 - not 60.", unilateral: true, bodyweight: false},
		{name: "Dumbbell", instructions: "Record the individual dumbell's weight - don't add both dumbells' weight together. 20 in each hand should be logged as 20 - not 40.", unilateral: true, bodyweight: false},
		{name: "Plate-loaded Machine", instructions: "A 'plated-loaded' machine does not have any integrated weight stack; free-weights are added to the machine akin to using barbells. Record the entire weight load, as you would with a barbell. If the machine you are using is not listed, use the 'placeholder' machine. Please contact us and let us know if you need a machine added'", unilateral: false, bodyweight: false},
		{name: "Selectorized Machine", instructions: "A 'selectorized' machine are most common and refer a machine with an integrated stack of weights; which the user then selects the load to be lifted. If the machine you are using is not listed, use the 'placeholder' machine. Please contact us and let us know if you need a machine added'", unilateral: false, bodyweight: false},
	]
end

