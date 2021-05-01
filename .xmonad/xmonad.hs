import XMonad
import System.IO( hPutStrLn)
import System.Exit (exitSuccess)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat, doRectFloat, (-?>))
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Layout.Spacing
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Actions.DynamicWorkspaces (addHiddenWorkspace)
import XMonad.Prompt
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Actions.CycleWS
import Data.Maybe (isJust)
import Data.Monoid
import XMonad.ManageHook 
import XMonad.Util.NamedScratchpad
import qualified XMonad.StackSet as W

rBdr  = 5
rCol1 = "#171423"
rCol2 = "#dadada"
rCol3 = "#666666"
rCol4 = "#ff3333"
rCol5 = "#dadada"
rFont = "xft:mononoki NF:size=9"

rTerminal               = "xterm" 
rModMask                = mod4Mask
rBorderWidth            = 2
rNormalBorderColor      = rCol1
rFocusedBorderColor     = rCol5
rFocusFollowMouse       = False
rClickJustFocuses       = True

pad :: String -> String
pad = wrap " " " "

rScratchpads::[NamedScratchpad]
rScratchpads = [ NS "terminal" (rTerminal ++ " -name terminal") (resource =? "terminal") (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
	       , NS "ssr" "simplescreenrecorder" (className =? "SimpleScreenRecorder") doCenterFloat 
	       , NS "vscode" "code" (className =? "Code") doFullFloat 
               , NS "fm" (rTerminal ++ " -e ranger") (title =? "ranger") (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7)) 
               , NS "network" (rTerminal ++ " -e nmtui") (title =? "nmtui") doCenterFloat 
       	       , NS "mplayer" (rTerminal ++ " -e cmus") (title =? "cmus") (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7)) 
               ]

--rStartupHook = do
--  spawnOnce "feh --bg-fill ~/.wallpaper/11-0-Color-Day.jpg &"
--  spawnOnce "brightnessctl set 5% &"
--  spawnOnce "xsetroot -cursor_name left_ptr &" 
--  spawnOnce "xset b off &"

rManageHook  = composeAll
  [ className =? "Pavucontrol"                  --> doCenterFloat
  , className =? "VirtualBox Manager"           --> doCenterFloat
  , className =? "mpv"                          --> doFullFloat
  , className =? "Sxiv"                         --> doCenterFloat
--  , className =? "Nitrogen"                     --> doCenterFloat
  , className =? "Lxappearance"                 --> doCenterFloat
--  , className =? "Gimp"                         --> doCenterFloat
  , title     =? "Save File"                    --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Open Folder"                  --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Open Files"                   --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Choose Files"                 --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Select a filename"            --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "File Upload"  	        --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Insert Image"  	        --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Question"                     --> doCenterFloat
  ] <+> namedScratchpadManageHook rScratchpads

rLayoutHook = avoidStruts $ layoutHook def 
--rLayoutHook = avoidStruts $ tiled ||| Mirror tiled ||| Full
--  where
--        tiled   = Tall nmaster delta ratio
--        nmaster = 1
--        ratio   = 1/2
--        delta   = 3/100

rRmKey = [ ("M-p")
        , ("M-q")
        , ("M-S-p")
        , ("M-w")
        , ("M-e")
        , ("M-r")
        , ("M-S-w")
        , ("M-S-e")
        , ("M-S-r")
        ]

rXPConfig = def  
          { font = rFont
          , bgColor = rCol1
          , fgColor = rCol2
          , bgHLight = rCol2
          , fgHLight = rCol1
          , borderColor = rCol2
          , promptBorderWidth = 0
          , position = Top
--          , position = CenteredAt 0.4 0.3 
          , height = 22
          , historySize = 256
          , historyFilter = id
          , defaultText = []
--          , searchPredicate = fuzzyMatch
          , autoComplete = Nothing
          , showCompletionOnTab = False
          , alwaysHighlight = True
          , maxComplRows = Just 1
          }

rKey =  [ ("M-S-<Return>", shellPrompt rXPConfig)
        , ("M-<Return>", spawn $ rTerminal)
        , ("M-S-q", io exitSuccess)
        , ("M-q", spawn "xmonad --recompile && xmonad --restart")
        , ("M-w", windows W.swapMaster)
        , ("<XF86AudioMute>", spawn "amixer -D pulse sset Master toggle")
        , ("<XF86AudioLowerVolume>", spawn "amixer -D pulse sset Master 4%-")
        , ("<XF86AudioRaiseVolume>", spawn "amixer -D pulse sset Master 4%+")
        , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 2%-")
        , ("<XF86MonBrightnessUp>", spawn "brightnessctl set 2%+")
        , ("<Print>", spawn "scrot ~/Pictures/scrot/%Y-%m-%d_%s.png")
        , ("M-<Print>", spawn "scrot -s ~/Pictures/scrot/%Y-%m-%d_%s.png")
        , ("M-S-<Print>", spawn "scrot .scrot.png && xclip -selection c -t image/png -i .scrot.png && rm .scrot.png")
        , ("M-C-<Print>", spawn "scrot -s .scrot.png && xclip -selection c -t image/png -i .scrot.png && rm .scrot.png")
        , ("M-S-f", spawn "firefox --private-window")
        , ("M-S-g", spawn "google-chrome --incognito")
      --, ("M-S-b", spawn "brave --incognito")
      --, ("M-S-x", spawn "xournalpp")
        , ("M-S-l", spawn "libreoffice")
        , ("M-b", spawn "killall xmobar")
        , ("M-S-p", spawn "pavucontrol")
        , ("M1-<Return>", namedScratchpadAction rScratchpads "terminal")
        , ("M-S-n", namedScratchpadAction rScratchpads "network")
        , ("M-S-m", namedScratchpadAction rScratchpads "mplayer")
        , ("M-S-s", namedScratchpadAction rScratchpads "ssr")
        , ("M-S-e", namedScratchpadAction rScratchpads "fm")
        , ("M-S-w", namedScratchpadAction rScratchpads "vscode")
        , ("M-S-<KP_Add>", shiftTo Next nonNSP >> moveTo Next nonNSP)
        , ("M-S-<KP_Subtract>", shiftTo Prev nonNSP >> moveTo Prev nonNSP)
        ]
        where nonNSP = WSIs (return (\ws -> W.tag ws /= "nsp"))
              nonEmptyNonNSP = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "nsp"))

main = do
 xmproc0 <- spawnPipe "xmobar"
 xmonad $ docks def
	{ handleEventHook       = XMonad.Hooks.EwmhDesktops.fullscreenEventHook
	, manageHook		= rManageHook 
	--, startupHook		= rStartupHook
	, workspaces		= ["1","2","3","4","5","6","7","8","9"]
	, layoutHook		= rLayoutHook
	, modMask 		= rModMask
	, terminal 		= rTerminal
	, logHook		= dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn xmproc0 
                                                            , ppTitle    = xmobarColor rCol2 "" . shorten 80
                                                            , ppCurrent  = xmobarColor rCol5 "" . wrap "[ " " ]" 
                                                            , ppHidden	 = xmobarColor rCol5 "" . wrap "" "" 
                                                            , ppHiddenNoWindows = xmobarColor rCol3 ""
                                                            , ppUrgent   = xmobarColor rCol1 rCol4 . wrap "!" "!" 
                                                            , ppSep	 =  ""
							    , ppSort     = fmap (. XMonad.Util.NamedScratchpad.namedScratchpadFilterOutWorkspace) (ppSort xmobarPP)
                                                            , ppLayout	 = xmobarColor rCol5 "" .
									  (\ x -> pad $ case x of
										"Spacing Tall" 		-> "[]="
										"Spacing Mirror Tall" 	-> "TTT"
										"Spacing Full" 		-> "[M]"
										_			-> x
									  )
							    }
	, borderWidth 		= rBorderWidth
	, normalBorderColor 	= rNormalBorderColor
	, focusedBorderColor 	= rFocusedBorderColor
	, focusFollowsMouse 	= rFocusFollowMouse
	, clickJustFocuses 	= rClickJustFocuses
	} `removeKeysP` rRmKey
	  `additionalKeysP` rKey
