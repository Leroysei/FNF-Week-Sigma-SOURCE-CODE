function start(song)

end

function update(elapsed)

end

function stepHit(step)
    if step == 122 then
        showOnlyStrums = true
    end
    if step == 171 then
        tweenFadeOut(1, 0, 1.5, "If you see this you a bitch")
        tweenFadeOut(2, 0, 1.5, "If you see this you a bitch")
        tweenFadeOut(4, 0, 1.5, "If you see this you a bitch")
        tweenFadeOut(5, 0, 1.5, "If you see this you a bitch")
        tweenFadeOut(6, 0, 1.5, "If you see this you a bitch")
        tweenFadeOut(7, 0, 1.5, "If you see this you a bitch")
    end
    if step == 438 then
        tweenFadeOut(0, 0, 1.5, "If you see this you a bitch")
        tweenFadeIn(1, 1, 1.5, "If you see this you a bitch")
        tweenFadeIn(2, 1, 1.5, "If you see this you a bitch")
        tweenFadeOut(3, 0, 1.5, "If you see this you a bitch")
    end
    if step == 576 then
        tweenFadeOut(1, 0, 0.00001, "If you see this you a bitch")
        tweenFadeOut(2, 0, 0.00001, "If you see this you a bitch")
    end
end

function beatHit(beat)

end

function playerTwoTurn()

end

function playerOneTurn()

end