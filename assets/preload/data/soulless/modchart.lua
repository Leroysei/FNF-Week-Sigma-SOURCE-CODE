function start(song)
    
    setActorAlpha(0,0)

    setActorAlpha(0,1)

    setActorAlpha(0,2)

    setActorAlpha(0,3)

    setActorAlpha(0,4)

    setActorAlpha(0,5)

    setActorAlpha(0,6)

    setActorAlpha(0,7)

end

function update(elapsed)
    if curBeat > 206 then
        local firstColumn = 0
        local secondColumn = 1150
        local currentBeat = (songPos / 1000)*(bpm/60)
		for i=0,3 do
			setActorX(firstColumn + 8 * math.sin((currentBeat + i*0.25) * math.pi), i)
		end
        for i=4,7 do
			setActorX(secondColumn + 8 * math.sin((currentBeat + i*0.25) * math.pi), i)
        end
    end
end

function stepHit(step)
    if step == 1514 then

        setActorAlpha(0,0)

        setActorAlpha(0,1)

        setActorAlpha(0,2)

        setActorAlpha(0,3)

        setActorAlpha(0,4)

        setActorAlpha(0,5)

        setActorAlpha(0,6)

        setActorAlpha(0,7)
    end
end

function beatHit(beat)
    if beat == 1 then
        tweenFadeIn(0, 1, 1.5, "If you see this you a bitch")
        tweenFadeIn(1, 1, 2, "If you see this you a bitch")
        tweenFadeIn(2, 1, 2.5, "If you see this you a bitch")
        tweenFadeIn(3, 1, 3, "If you see this you a bitch")
        tweenFadeIn(4, 1, 1.5, "If you see this you a bitch")
        tweenFadeIn(5, 1, 2, "If you see this you a bitch")
        tweenFadeIn(6, 1, 2.5, "If you see this you a bitch")
        tweenFadeIn(7, 1, 3, "If you see this you a bitch")
    end
    if beat == 206 then
        local firstRow = 0
        local secondRow = 100 
        local thirdRow  = 200
        local fourthRow = 300
        local firstColumn = 0
        local secondColumn = 1150

        setActorX(firstColumn, 0)
        setActorY(firstRow, 0)

        setActorX(firstColumn, 1)
        setActorY(secondRow, 1)

        setActorX(firstColumn, 2)
        setActorY(thirdRow, 2)

        setActorX(firstColumn, 3)
        setActorY(fourthRow, 3)

        setActorX(secondColumn, 4)
        setActorY(firstRow, 4)

        setActorX(secondColumn, 5)
        setActorY(secondRow, 5)

        setActorX(secondColumn, 6)
        setActorY(thirdRow, 6)

        setActorX(secondColumn, 7)
        setActorY(fourthRow, 7)
       
    end
end

function playerTwoTurn()

end

function playerOneTurn()

end