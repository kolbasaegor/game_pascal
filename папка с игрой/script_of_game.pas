//2017 Stroganov Egor

program fallout2D;

uses GraphABC;
var
  player_l, player_r, location, pipboy, bot, gameover,
  HighHP, MediumHP, LowHP, pistol, player_l_p, player_r_p,
  HighHPbot, MediumHPbot, LowHPbot, bot50,
  bot25, bot0, shoot, shoot_l, damage: picture;
  
  x, y, xbot, ybot, xb, yb, left, right, up, down, 
  v, vbot, inventory, hp, fire, hpbot, m, ammo:integer;
  
  game, gun: boolean;

procedure KeyDown(Key: integer);
begin
  if Key = vk_w then up := 1;
  if Key = vk_a then left := 1;
  if Key = vk_s then down := 1;
  if Key = vk_d then right := 1;
  if Key = vk_TAB then inventory := 1;
  if Key = vk_k then m:=m+1;
end;

procedure KeyUp(Key: integer);
begin
  if Key = vk_w then up := 0;
  if Key = vk_a then left := 0;
  if Key = vk_s then down := 0;
  if Key = vk_d then right := 0;
  if Key = vk_TAB then inventory := 0;
  if Key = vk_k then m:=m;
end;

begin
  window.title := 'fallout2D';
  window.Left := 100;
  window.Top := 100;
  SetWindowSize(1600, 872);
  OnkeyDown := KeyDown;
  OnkeyUp := KeyUp;
  v := 4;
  vbot := 2;
    {data}
    damage := Picture.Create('data\damage.png');
    shoot_l := Picture.Create('data\shoot_l.png');
    shoot := Picture.Create('data\shoot.png');
    bot50 := Picture.Create('data\bot50.png');
    bot25 := Picture.Create('data\bot25.png');
    bot0 := Picture.Create('data\bot0.png');
    pistol := Picture.Create('data\10mm.png');
    player_l_p := Picture.Create('data\vault-boy-left+gun.png');
    player_r_p := Picture.Create('data\vault-boy-right+gun.png');
    gameover := Picture.Create('data\gameover.jpg');
    bot := Picture.Create('data\bot.png');
    pipboy := Picture.Create('data\pipboy.png');
    player_l := Picture.Create('data\vault-boy-left.png');
    player_r := Picture.Create('data\vault-boy-right.png');
    location := Picture.Create('data\location.jpg');
    HighHP := Picture.Create('data\HighHP.png');
    MediumHP := Picture.Create('data\MediumHP.png');
    LowHP := Picture.Create('data\LowHP.png');
    HighHPbot := Picture.Create('data\HighHPbot.png');
    MediumHPbot := Picture.Create('data\MediumHPbot.png');
    LowHPbot := Picture.Create('data\LowHPbot.png');
  game := true;
    hp := 100;
    hpbot := 150;
    ammo := 24;
    x := (Window.Width div 2); y := (Window.Height div 2); 
    xbot := random(0,1500);
    ybot := random(0,700);
  LockDrawing; 
  {Öèêë èãðû} 
  while (game = true) do
  begin
      {Ïðîâåðêà íà æèçíü}
    if hp <= 0 then begin
      gameover.Draw(0, 0);
      game := false;
    end;
    location.Draw(0, 0);
    {Äâèæåíèå} 
    if(left = 1) and (gun = true) then player_l_p.Draw(x, y);
    if(left = 1) and (gun = false) then player_l.Draw(x, y);
    if(left = 0) and (gun = true) then player_r_p.Draw(x, y);
    if(left = 0) and (gun = false) then player_r.Draw(x, y);
    if right = 1 then x := x + v;
    if left = 1 then x := x - v;
    if up = 1 then y := y - v;
    if down = 1 then y := y + v;
    {Ñòàòû}
    if hp >= 80 then HighHP.Draw(1300, 0);
    if (hp >= 30) and (hp < 80) then MediumHP.Draw(1300, 0);
    if (hp < 30) and (hp > 0) then LowHP.Draw(1300, 0);
      if hpbot >= 100 then begin HighHPbot.Draw(xbot - 5, ybot - 10); bot.Draw(xbot, ybot); end;
      if (hpbot >= 50) and (hpbot < 100) then begin MediumHPbot.Draw(xbot - 5, ybot - 10); bot50.Draw(xbot, ybot); end;
      if (hpbot < 50) and (hpbot > 0) then begin LowHPbot.Draw(xbot - 5, ybot - 10); bot25.Draw(xbot, ybot); end;
      {Óðîí} {Îò áîòà}
      if hpbot > 0 then 
    if (((xbot + 20 < x)  and (xbot >= x)) and ((ybot + 40 < y)  and (ybot >= y)))
     or (((xbot - 20 < x)  and (xbot >= x)) and ((ybot - 40 < y)  and (ybot >= y)))
     or (((xbot - 20 < x)  and (xbot >= x)) and ((ybot + 40 < y)  and (ybot >= y)))
     or (((xbot + 20 < x)  and (xbot >= x)) and ((ybot - 40 < y)  and (ybot >= y)))
     then hp := hp - 2; 
      {Îò èãðîêà}
      if left = 1 then xb := x + 6;
      if left = 0 then xb := x + 79;
      yb := y + 23;
   if m>0 then fire:=1 else fire:= 0;
      if (fire = 1)and(gun = true)and(ammo>0) then begin 
       if left = 0 then shoot.Draw(x+79,y+13);
       if left = 1 then shoot_l.Draw(x-5,y+13);
        if (left = 0) and (x < xbot) then 
          if (yb < ybot + 142) and (yb > ybot) then 
          begin 
          hpbot := hpbot - 10;
          Line(xb, yb, xbot+40, yb,clYellow);
          damage.Draw(xbot+40, yb);
          end;
        if (left = 1) and (x > xbot) then 
          if (yb < ybot + 142) and (yb > ybot) then 
          begin
          hpbot := hpbot - 10;
          Line(xb, yb, xbot+40, yb,clYellow);
          damage.Draw(xbot+40, yb);
          end;
          ammo := ammo-1;
         end;
        m:=0;
      {Ìèð}
    if (x = 0) then left := 0;
    if (x + 84 = 1600) then right := 0;
    if (y = 0) then up := 0;
    if ((y + 100) = 872) then down := 0;
     {Ïèñòîëåò}
    if gun = false then begin
      pistol.Draw(1300, 200);
      if (((1300 + 20 < x)  and (1300 + 160 >= x)) and ((200 + 20 < y)  and (200 + 20 >= y)))
      or (((1300 - 20 < x)  and (1300 + 160 >= x)) and ((200 - 20 < y)  and (200 + 20 >= y)))
      or (((1300 - 20 < x)  and (1300 + 160 >= x)) and ((200 + 20 < y)  and (200 + 20 >= y)))
      or (((1300 + 20 < x)  and (1300 + 160 >= x)) and ((200 - 20 < y)  and (200 + 20 >= y)))
        then 
        gun := true;
    end;
      {Áîò}
    if hpbot > 0 then begin
      if xbot > x then xbot := xbot - vbot;
      if xbot < x then xbot := xbot + vbot;
      if ybot > y then ybot := ybot - vbot;
      if ybot < y then ybot := ybot + vbot; end; 
    if inventory = 0 then vbot := 3;
      if hpbot <= 0 then bot0.Draw(xbot, ybot);
      {Èíâåíòàðü}
    if  inventory = 1 then
    begin
      left := 0; right := 0; up := 0; down := 0;   
      vbot := 0;
      pipboy.Draw(400, 200);
    end;
      {Ñìåðòü}
    if hp <= 0 then  gameover.Draw(0, 0); 
    redraw;
  end;
end.   
