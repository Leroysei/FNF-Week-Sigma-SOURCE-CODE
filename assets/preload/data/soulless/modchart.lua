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
        local currentBeat = (songPos / 1000)*(bpm/60)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 8 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 8 * math.cos((currentBeat + i*0.25) * math.pi), i)
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
end

function playerTwoTurn()

end

function playerOneTurn()

end