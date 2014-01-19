#!/usr/bin/env ruby

def gridCreate(rows, columns)  # draws grid[x][y]
	grid=[]
	rows.times do |r|
		grid[r] = []
		columns.times do |c|
			grid[r][c] = '.'
		end	
	end	
	return grid
end 

def lowRow(grid) #erasing low row when filled
	grid.each do |row|
		if row.count == row.grep('#').size
			row.map!{|i|'.'}
			@score = @score + row.count
		end

	end
end

def cube(grid,x,y) # left bottom is start of coords
	# leftXY = (grid.first.count / 2).round(1)-1
	grid[0].map!{|i| '.'} #clearing previous state
	grid[1].map!{|i| '.'} #clearing previous state

	grid[y][x] 			= '#'	#bottom left 
	grid[y][x+1] 		= '#'	#top right 
	grid[y-1][x] 		= '#'	#bottom right 
	grid[y-1][x+1] 		= '#'	#top left  
end	

def checkLand(grid) #returns coord for landing cube
	#index for X coord and Y in itteration position 
	cor={}
	grid.each_with_index do |row,ind| #checking rows
		rowstr = row.join('')
		if rowstr.include? ".."
			cor[:gr] = row #for debugging
			cor[:x] = rowstr.index('..') 
			cor[:y] = ind			
		end
		
	end
	return cor
end	

def gridOut(grid,step,cycle,score) #grid output
	columns = grid.first.count
	print "rows: #{grid.count} | columns: #{columns}\n"
	print "------------------------------\n"
	grid.each_with_index{|l,ind| print "y#{ind} | " + l.join() + "\n"}	

	print "   x-#{columns.times.map{|i| i}.join('')}\n"
	print "------------------------------\n"
	print "step: #{step} | cycle: #{cycle} | score:#{score} \n"
	sleep 0.5   #SPEED
	system('clear')
end	

	
#input params 
	system('clear')
	cycle = []
	@score = 0 

	puts 'please input number of rows'
	user_rows = gets.to_i

	puts 'please input number of columns'
	user_columns = gets.to_i

	system('clear') 

#starting
grid = gridCreate(user_rows,user_columns) #rows,columns like 5,4
	gridOut(grid, 0, cycle.count,@score)

cycle << grid

loop do 
	cube(cycle.last,1,1)	#initiate cube
		gridOut(cycle.last, 1, cycle.count,@score)
		
	cube(cycle.last, checkLand(cycle.last)[:x], 1 ) #position
		gridOut(cycle.last, 2,cycle.count,@score)

	cube(cycle.last, checkLand(cycle.last)[:x], checkLand(cycle.last)[:y] )#landing
		gridOut(grid, 3,cycle.count,@score)	

	lowRow(grid) #takes filled rows away
		gridOut(grid, 4,cycle.count,@score)

	cycle << cycle.last #add last state to cycle
end	








