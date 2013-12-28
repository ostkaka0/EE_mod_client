package 
{
    import SWFStats.*;
    
    import blitter.*;
    
    import chat.*;
    
    import flash.external.*;
    import flash.utils.*;
    
    import playerio.*;
    
    import utility.*;
	
    public class mygame extends blitter.BlGame
    {
		
		
        public function mygame()
        {
			//Compressor.CompressQuadTree(null, null, 0, 0, 0, 0);
			//Compressor.DecompressQuadTree(null, null, 0, 0, 0, 0);
			//Compressor.
			
			
            var lstate:LoadState;
            var roomname:String;

            var loc1:*;
            lstate = null;
            roomname = null;
            super(Config.viewWidth, Config.viewHeight, 1);//super(640, 480, 1);
            GamesChart.setup(stage, "8fae8746331b5cab59722c931f6741e7");
            GamesChart.hideTab();
            SWFStats.Log.View(407, "b24c9cd3-870b-49ac-b017-cbee232cf768", root.loaderInfo.loaderURL);
            blitter.Bl.data.showMap = false;
            blitter.Bl.data.canEdit = true;
            lstate = new LoadState();
            state = lstate;
            roomname = "";
            if (flash.external.ExternalInterface.available) 
            {
                try 
                {
                    roomname = flash.external.ExternalInterface.call("ee_roomname.toString");
                    this.iseecom = flash.external.ExternalInterface.call("iseecom.toString") == "true";
                }
                catch (e:Error)
                {
                };
            }
			showLogin();
            /*playerio.PlayerIO.connect(stage, "eeo-ruiegvlaw0sdzzak1msc3a", "public", "whatever", "", function (arg1:playerio.Client):void
            {
                var c:playerio.Client;

                var loc1:*;
                c = arg1;
                client = c;
                if (roomname) 
                {
                    flash.utils.setTimeout(function ():void
                    {
                        var loc1:*;
                        lstate.fadeOut(function ():void
                        {
                            joinRoom(roomname, true);
                            return;
                        })
                        return;
                    }, 1000)
                }
                else 
                {
                    showLobby(lstate);
                }
                return;
            }, this.handleError)*/
            return;
			
			
        }
		
		private function showLogin(arg1:LoadState=null) : void
		{
			var lstate:LoadState=null;
			lstate = arg1;
			if (lstate == null) 
			{
				lstate = new LoadState()
				lstate.fadeOut(function():void
				{

						flash.utils.setTimeout(function ():void
						{
							var loc1:*;
							lstate.fadeOut(function ():void
							{
								state = new LoginState(function(c:Client):void { client = c; showLobby(null)});//joinRoom(roomname, true);
								return;
							})
							return;
						}, 1);

					return;
				});
				
			}
			state = lstate;
			return;
		}

        private function showLobby(arg1:LoadState=null):void
        {
            var lstate:LoadState=null;

            var loc1:*;
            lstate = arg1;
            if (lstate == null) 
            {
                lstate = new LoadState();
            }
            state = lstate;
            flash.utils.setTimeout(function ():void
            {
                var loc1:*;
                client.multiplayer.listRooms("EE070O", {}, 0, 0, function (arg1:Array):void
                {
                    var rooms:Array;

                    var loc1:*;
                    rooms = arg1;
                    lstate.fadeOut(function ():void
                    {
                        state = new LobbyState(rooms, joinRoom, createRoom, iseecom);
                        return;
                    })
                    return;
                })
                return;
            }, 1000)
            return;
        }

        private function joinRoom(arg1:String, arg2:Boolean=false):void
        {
            var rid:String;
            var direct:Boolean=false;

            var loc1:*;
            rid = arg1;
            direct = arg2;
            state = new JoinState();
			
            this.client.multiplayer.joinRoom(rid, {}, function (arg1:playerio.Connection):void
            {
                handleJoin(arg1, rid, direct);
                return;
            }, function (arg1:playerio.PlayerIOError):void
            {
                showLobby();
                return;
            })
            return;
        }

        private function handleJoin(arg1:playerio.Connection, arg2:String, arg3:Boolean=false, arg4:Boolean=false):void
        {
            var connection:playerio.Connection;
            var roomid:String;
            var direct:Boolean=false;
            var isLockedRoom:Boolean=false;

            var loc1:*;
            connection = arg1;
            roomid = arg2;
            direct = arg3;
            isLockedRoom = arg4;
            SWFStats.Log.Play();
			
            connection.addMessageHandler("init", function (arg1:playerio.Message, arg2:int, name:String, arg3:Boolean, isDeflated:Boolean, byteArray:ByteArray):void
            {
                var m:playerio.Message;
                var id:int;
                var canEdit:Boolean;
                var levelArr:Array;
                var crow:Array;
                var a:int;

                var loc1:*;
                m = arg1;
                id = arg2;
                canEdit = arg3;
                blitter.Bl.data.isLockedRoom = isLockedRoom || !canEdit;
                //levelArr = [];
                //crow = [];
                a = 3;
                /*while (a < m.length) 
                {
                    if (crow.length >= 200) 
                    {
                        levelArr.push(crow);
                        crow = [];
                    }
                    crow.push(m.getInt(a));
                    ++a;
                }*/
				
				//((var temp:*= utility.Compressor.
				
                /*levelArr.push(crow);
				
				var temp:ByteArray = new ByteArray;
				utility.Compressor.CompressQuadTree(levelArr, temp, 1, 1, 199, 199);
				
				trace("World compressed to " + temp.length.toString() + " bytes.");
				
				/*levelArr = [];* /
				
				for (var yyy:int = 1; yyy < 199; yyy++)
				{
					for (var xxx:int = 1; xxx < 199; xxx++)
					{
						levelArr[yyy][xxx] = 22;
					}
				}
				
				trace("World decompressed from " + utility.Compressor.DecompressQuadTree(levelArr, temp, 1, 1, 199, 199).toString() + " bytes.");
				*/
				levelArr = [200];
				
				for (var x:int = 0; x < 200; x++)
				{
					levelArr[x] = [200];
				}
				
				/*if (isDeflated)
				{
					trace("Deflate-compressed size of byte array: " + byteArray.length.toString());
					
					byteArray.inflate();
				}
				trace("QuadTree-Compressed size of byte array: " + byteArray.length.toString());
				
				//utility.Compressor.
				//var size:int = utility.Compressor.DecompressQuadTree(levelArr, new utility.ByteQueueReader(byteArray), 1, 1, 199, 199);
				
				//trace("World decompressed from " + size.toString() + " bytes.");
				
				byteArray.compress();//.deflate();
				
				trace(byteArray.length.toString());
				
				byteArray.uncompress();
				
				trace(byteArray.length.toString());
				//byteArray.de
				*/
				
				levelArr = Compressor.DecompressWorld(new CompressedData(isDeflated, byteArray));
				
				var levelArr2:Array = [200];
				
				for(var y:int = 0; y < 200; y++)
				{
					levelArr2[y] = [200];
					for (var xx:int = 0; xx < 200; xx++)
					{
						if (xx == 0 || xx == 199 || y == 0 || y == 199)
							levelArr2[y][xx] = 9;
						else
							levelArr2[y][xx] = levelArr[xx][y];
					}
				}
				
                state = new PlayState(connection, levelArr2, id, name);
                blitter.Bl.data.canEdit = canEdit;
                var loc2:*;
				
				sidechat = new chat.SideChat(connection);
				sidechat.x = 640 - 1;
				if (sidechat) 
				{
					sidechat.setMe(arg2.toString(), name, Player.isAdmin(name));
					//align = flash.display.StageAlign.TOP_LEFT;
					addChild(sidechat);//AddChild(sidechat);
				}
				
                ui = loc2 = new GameInterface(connection, canEdit, roomid, direct, iseecom, sidechat,
				function ():void
                {
                    removeChild(ui);
					removeChild(sidechat);
                    if (connection.connected) 
                    {
                        connection.disconnect();
                    }
                    showLobby();
                    return;
                });
                addChild(loc2);
				
				
				
                return;
            })
            connection.send("init");
            connection.addDisconnectHandler(function ():void
            {
                showLobby();
                if (ui && ui.parent) 
                {
                    removeChild(ui);
                }
				if (sidechat)
				{
					removeChild(sidechat);
					sidechat = null;
				}
                return;
            })
            return;
        }

        private function createRoom(arg1:String, arg2:String=""):void
        {
            var rid:String;
            var editkey:String="";
            var roomid:String;
			var needskey:Boolean;
			var roominfo:Object = [];

            var loc1:*;
            roomid = null;
            rid = arg1;
            editkey = arg2;
			needskey = (editkey.split("/")[0] != "")
            state = new JoinState();
            roomid = ((Math.random() * 1000 >> 0) + new Date().getMilliseconds()).toString(36) + " " + rid;
			
			if (editkey != "")
			{
				//editkey != "" ? {"editkey":editkey, "name":rid, "needskey":needskey} : {"name":rid}
				if (needskey)
				{
					roominfo = {"name":rid, "editkey":editkey, "needskey":true};
				}
				else
				{
					roominfo = {"name":rid, "editkey":editkey}
				}
			}
			else
			{
				roominfo = {"name":rid};
			}
			
            this.client.multiplayer.createJoinRoom(roomid, "EE070O", true, roominfo , editkey != "" ? {"editkey":editkey} : {}, function (arg1:playerio.Connection):void
            {
                handleJoin(arg1, roomid, false, needskey);
                return;
            }, function (arg1:playerio.PlayerIOError):void
            {
                showLobby();
                return;
            })
            return;
        }

        private function handleError(arg1:playerio.PlayerIOError):void
        {
            trace("Got", arg1);
            return;
        }

        protected var client:playerio.Client;

        protected var ui:GameInterface;

        protected var iseecom:Boolean=false;
		
		protected var sidechat:SideChat;
    }
}
