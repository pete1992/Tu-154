size = {240, 850}
defineProperty("hide_eng_objects", globalPropertyi("tu154ce/lang/hide_eng_objects")) 
defineProperty("show_checklist_panel",globalPropertyi("tu154ce/panels/show_checklist_panel")) 
defineProperty("side",globalPropertyi("tu154ce/checklist/side")) 
defineProperty("fishka_1",globalPropertyi("tu154ce/checklist/fishka_1")) 
defineProperty("fishka_2",globalPropertyi("tu154ce/checklist/fishka_2")) 
defineProperty("fishka_3",globalPropertyi("tu154ce/checklist/fishka_3")) 
defineProperty("fishka_4",globalPropertyi("tu154ce/checklist/fishka_4")) 
defineProperty("fishka_5",globalPropertyi("tu154ce/checklist/fishka_5")) 
defineProperty("fishka_6",globalPropertyi("tu154ce/checklist/fishka_6")) 
defineProperty("fishka_7",globalPropertyi("tu154ce/checklist/fishka_7")) 
defineProperty("fishka_8",globalPropertyi("tu154ce/checklist/fishka_8")) 
defineProperty("fishka_9",globalPropertyi("tu154ce/checklist/fishka_9")) 
defineProperty("fishka_10",globalPropertyi("tu154ce/checklist/fishka_10")) 
defineProperty("fishka_11",globalPropertyi("tu154ce/checklist/fishka_11")) 
defineProperty("fishka_12",globalPropertyi("tu154ce/checklist/fishka_12")) 
defineProperty("fishka_13",globalPropertyi("tu154ce/checklist/fishka_13")) 
defineProperty("fishka_14",globalPropertyi("tu154ce/checklist/fishka_14")) 
defineProperty("fishka_15",globalPropertyi("tu154ce/checklist/fishka_15")) 
defineProperty("fishka_16",globalPropertyi("tu154ce/checklist/fishka_16")) 
defineProperty("fishka_17",globalPropertyi("tu154ce/checklist/fishka_17")) 
defineProperty("fishka_18",globalPropertyi("tu154ce/checklist/fishka_18")) 
defineProperty("fishka_19",globalPropertyi("tu154ce/checklist/fishka_19")) 
defineProperty("fishka_20",globalPropertyi("tu154ce/checklist/fishka_20")) 
defineProperty("checklist_selected",globalPropertyi("tu154ce/checklist/checklist_selected")) 
defineProperty("bg_img_0", loadImage("checklist_tex.png", 0, 0, 240, 850))
defineProperty("bg_img_1", loadImage("checklist_tex.png", 249, 0, 240, 850))
defineProperty("bg_img_0_RUS", loadImage("checklist_tex_RUS.png", 0, 0, 240, 850))
defineProperty("bg_img_1_RUS", loadImage("checklist_tex_RUS.png", 249, 0, 240, 850))
defineProperty("fishka_left", loadImage("checklist_tex.png", 0, 859, 166, 25))
defineProperty("fishka_right", loadImage("checklist_tex.png", 0, 887, 166, 25))
components = {
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img_0),
		visible = function()
			return get(side) == 0 and get(hide_eng_objects) == 0
		end,
	},	
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img_1),
		visible = function()
			return get(side) == 1 and get(hide_eng_objects) == 0
		end,
	},	
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img_0_RUS),
		visible = function()
			return get(side) == 0 and get(hide_eng_objects) == 1
		end,
	},	
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img_1_RUS),
		visible = function()
			return get(side) == 1 and get(hide_eng_objects) == 1
		end,
	},
	clickable {
		position = {58, 788, 122, 15},
		onMouseClick = function() 
			set(side, 1 - get(side))
			return true
		end,
	},	
	clickable {
		position = {4, 424, 28, 350},
		onMouseClick = function() 
			set(fishka_1, 1)
			set(fishka_2, 1)
			set(fishka_3, 1)
			set(fishka_4, 1)
			set(fishka_5, 1)
			set(fishka_6, 1)
			set(fishka_7, 1)
			set(fishka_8, 1)
			set(fishka_9, 1)
			set(fishka_10, 1)
			if get(checklist_selected) ~=1 then set(checklist_selected, 1) end
			return true
		end,
		onMouseUp = function() 
			return true
		end,
		visible = function()
			return get(side) == 0
		end,
	},	
	clickable {
		position = {4, 57, 28, 350},
		onMouseClick = function() 
			set(fishka_11, 1)
			set(fishka_12, 1)
			set(fishka_13, 1)
			set(fishka_14, 1)
			set(fishka_15, 1)
			set(fishka_16, 1)
			set(fishka_17, 1)
			set(fishka_18, 1)
			set(fishka_19, 1)
			set(fishka_20, 1)
			if get(checklist_selected) ~=2 then set(checklist_selected, 2) end
			return true
		end,
		onMouseUp = function() 
			return true
		end,
		visible = function()
			return get(side) == 0
		end,
	},	
	clickable {
		position = {207, 688, 28, 91},
		onMouseClick = function() 
			set(fishka_1, 0)
			set(fishka_2, 0)
			set(fishka_3, 0)
			if get(checklist_selected) ~=3 then set(checklist_selected, 3) end
			return true
		end,
		onMouseUp = function() 
			return true
		end,
		visible = function()
			return get(side) == 0
		end,
	},	
	clickable {
		position = {207, 350, 28, 327},
		onMouseClick = function() 
			set(fishka_4, 0)
			set(fishka_5, 0)
			set(fishka_6, 0)
			set(fishka_7, 0)
			set(fishka_8, 0)
			set(fishka_9, 0)
			set(fishka_10, 0)
			set(fishka_11, 0)
			set(fishka_12, 0)
			if get(checklist_selected) ~=4 then set(checklist_selected, 4) end
			return true
		end,
		onMouseUp = function() 
			return true
		end,
		visible = function()
			return get(side) == 0
		end,
	},		
	clickable {
		position = {207, 48, 28, 289},
		onMouseClick = function() 
			set(fishka_13, 0)
			set(fishka_14, 0)
			set(fishka_15, 0)
			set(fishka_16, 0)
			set(fishka_17, 0)
			set(fishka_18, 0)
			set(fishka_19, 0)
			set(fishka_20, 0)
			if get(checklist_selected) ~=5 then set(checklist_selected, 5) end
			return true
		end,
		onMouseUp = function() 
			return true
		end,
		visible = function()
			return get(side) == 0
		end,
	},	
	clickable {
		position = {4, 270, 28, 257},
		onMouseClick = function() 
			set(fishka_8, 1)
			set(fishka_9, 1)
			set(fishka_10, 1)
			set(fishka_11, 1)
			set(fishka_12, 1)
			set(fishka_13, 1)
			set(fishka_14, 1)
			if get(checklist_selected) ~=6 then set(checklist_selected, 6) end
			return true
		end,
		onMouseUp = function() 
			return true
		end,
		visible = function()
			return get(side) == 1
		end,
	},		
	clickable {
		position = {4, 47, 28, 213},
		onMouseClick = function() 
			set(fishka_15, 1)
			set(fishka_16, 1)
			set(fishka_17, 1)
			set(fishka_18, 1)
			set(fishka_19, 1)
			set(fishka_20, 1)
			if get(checklist_selected) ~=7 then set(checklist_selected, 7) end
			return true
		end,
		onMouseUp = function() 
			return true
		end,
		visible = function()
			return get(side) == 1
		end,
	},		
	clickable {
		position = {207, 462, 28, 315},
		onMouseClick = function() 
			set(fishka_1, 0)
			set(fishka_2, 0)
			set(fishka_3, 0)
			set(fishka_4, 0)
			set(fishka_5, 0)
			set(fishka_6, 0)
			set(fishka_7, 0)
			set(fishka_8, 0)
			set(fishka_9, 0)
			if get(checklist_selected) ~=8 then set(checklist_selected, 8) end
			return true
		end,
		onMouseUp = function() 
			return true
		end,
		visible = function()
			return get(side) == 1
		end,
	},		
	clickable {
		position = {207, 50, 28, 396},
		onMouseClick = function() 
			set(fishka_10, 0)
			set(fishka_11, 0)
			set(fishka_12, 0)
			set(fishka_13, 0)
			set(fishka_14, 0)
			set(fishka_15, 0)
			set(fishka_16, 0)
			set(fishka_17, 0)
			set(fishka_18, 0)
			set(fishka_19, 0)
			set(fishka_20, 0)
			if get(checklist_selected) ~=9 then set(checklist_selected, 9) end
			return true
		end,
		onMouseUp = function() 
			return true
		end,
		visible = function()
			return get(side) == 1
		end,
	},	
	switch_lit {
		position = {35, 758, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_1) == 1
		end,
		onMouseDown = function()
			set(fishka_1, 1 - get(fishka_1))
			return true
		end,
	},	
	switch_lit {
		position = {35, 720, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_2) == 1
		end,
		onMouseDown = function()
			set(fishka_2, 1 - get(fishka_2))
			return true
		end,
	},	
	switch_lit {
		position = {35, 684, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_3) == 1
		end,
		onMouseDown = function()
			set(fishka_3, 1 - get(fishka_3))
			return true
		end,
	},	
	switch_lit {
		position = {35, 646, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_4) == 1
		end,
		onMouseDown = function()
			set(fishka_4, 1 - get(fishka_4))
			return true
		end,
	},	
	switch_lit {
		position = {35, 608, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_5) == 1
		end,
		onMouseDown = function()
			set(fishka_5, 1 - get(fishka_5))
			return true
		end,
	},		
	switch_lit {
		position = {35, 570, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_6) == 1
		end,
		onMouseDown = function()
			set(fishka_6, 1 - get(fishka_6))
			return true
		end,
	},		
	switch_lit {
		position = {35, 533, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_7) == 1
		end,
		onMouseDown = function()
			set(fishka_7, 1 - get(fishka_7))
			return true
		end,
	},	
	switch_lit {
		position = {35, 495, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_8) == 1
		end,
		onMouseDown = function()
			set(fishka_8, 1 - get(fishka_8))
			return true
		end,
	},
	switch_lit {
		position = {35, 457, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_9) == 1
		end,
		onMouseDown = function()
			set(fishka_9, 1 - get(fishka_9))
			return true
		end,
	},
	switch_lit {
		position = {35, 418, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_10) == 1
		end,
		onMouseDown = function()
			set(fishka_10, 1 - get(fishka_10))
			return true
		end,
	},	
	switch_lit {
		position = {35, 379, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_11) == 1
		end,
		onMouseDown = function()
			set(fishka_11, 1 - get(fishka_11))
			return true
		end,
	},	
	switch_lit {
		position = {35, 342, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_12) == 1
		end,
		onMouseDown = function()
			set(fishka_12, 1 - get(fishka_12))
			return true
		end,
	},
	switch_lit {
		position = {35, 305, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_13) == 1
		end,
		onMouseDown = function()
			set(fishka_13, 1 - get(fishka_13))
			return true
		end,
	},
	switch_lit {
		position = {35, 267, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_14) == 1
		end,
		onMouseDown = function()
			set(fishka_14, 1 - get(fishka_14))
			return true
		end,
	},
	switch_lit {
		position = {35, 229, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_15) == 1
		end,
		onMouseDown = function()
			set(fishka_15, 1 - get(fishka_15))
			return true
		end,
	},
	switch_lit {
		position = {35, 193, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_16) == 1
		end,
		onMouseDown = function()
			set(fishka_16, 1 - get(fishka_16))
			return true
		end,
	},
	switch_lit {
		position = {35, 154, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_17) == 1
		end,
		onMouseDown = function()
			set(fishka_17, 1 - get(fishka_17))
			return true
		end,
	},
	switch_lit {
		position = {35, 117, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_18) == 1
		end,
		onMouseDown = function()
			set(fishka_18, 1 - get(fishka_18))
			return true
		end,
	},
	switch_lit {
		position = {35, 80, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_19) == 1
		end,
		onMouseDown = function()
			set(fishka_19, 1 - get(fishka_19))
			return true
		end,
	},
	switch_lit {
		position = {35, 44, 166, 25},
		btnOn = get(fishka_right),
		btnOff = get(fishka_left),
		state = function()
			return get(fishka_20) == 1
		end,
		onMouseDown = function()
			set(fishka_20, 1 - get(fishka_20))
			return true
		end,
	},
	clickable {
		position = {size[1] - 30, size[2] - 30, 30, 30 },
		onMouseClick = function() 
			set(show_checklist_panel, 0)
			return true
		end,
	}, 	
}
