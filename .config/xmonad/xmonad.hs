import XMonad
import System.IO( hPutStrLn)
import System.Exit (exitSuccess)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat, doRectFloat, (-?>))
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Layout.Spacing
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Actions.DynamicWorkspaces (addHiddenWorkspace)
import XMonad.Prompt
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.FuzzyMatch
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Actions.CycleWS
import Data.Maybe (isJust)
import Data.Monoid
import XMonad.ManageHook 
import XMonad.Util.NamedScratchpad
import XMonad.Util.WorkspaceCompare (filterOutWs)
import qualified XMonad.Util.Hacks as Hacks
import qualified XMonad.StackSet as W

myBdr  = 4
myCol1 = "#1A1B26" -- Background Color
myCol2 = "#C0CAF5" -- Foreground Color
myCol3 = "#414868" -- Inactive Color
myCol4 = "#F7768E" -- Warning Color
myCol5 = "#C0CAF5" -- Border Color
myFont = "xft:JetBrainsMono NF:size=10"

myTerminal               = "alacritty" 
myModMask                = mod4Mask
myBorderWidth            = 4
myNormalBorderColor      = myCol1
myFocusedBorderColor     = myCol5
myFocusFollowMouse       = False
myClickJustFocuses       = True

pad :: String -> String
pad = wrap " " " "

myScratchpads::[NamedScratchpad]
myScratchpads = 
  [ NS "terminal" (myTerminal ++ " --title myTerminal") (title=? "myTerminal") (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , NS "ssr" "simplescreenrecorder" (className =? "SimpleScreenRecorder") doCenterFloat 
  , NS "vscode" "code" (className =? "Code") doFullFloat 
  , NS "sublime" "subl" (className =? "Sublime_text") (customFloating $ W.RationalRect (0.0001) (0.03) (1) (0.97)) 
  , NS "fm" (myTerminal ++ " --title file-manager -e ranger") (title =? "file-manager") (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7)) 
  , NS "network" (myTerminal ++ " --title network-manager -e nmtui") (title =? "network-manager") doCenterFloat 
  , NS "mplayer" (myTerminal ++ " --title music -e cmus") (title =? "music") (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7)) 
  , NS "calculator" (myTerminal ++ " --title calculator -e python") (title =? "calculator") (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7)) 
  ]

myStartupHook = do
  spawnOnce "~/.fehbg &"
  spawnOnce "picom -b &"
  spawnOnce "dunst &"
  spawnOnce "flameshot &"
  spawnOnce "xsetroot -cursor_name left_ptr &"
  spawnOnce "slstatus &"

myManageHook  = composeAll
  [ className =? "VirtualBox Manager" --> doCenterFloat
  , className =? "mpv" --> doFullFloat
  , className =? "Sxiv" --> doCenterFloat
  , className =? "Lxappearance" --> doCenterFloat
  , title     =? "Save File" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Change color of selected text" --> doCenterFloat
  , title     =? "Quit GIMP" --> doCenterFloat
  , title     =? "Change Foreground Color" --> doCenterFloat
  , title     =? "Open Folder" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Open Folder" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Select Folder" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Print" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Open Files" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Open File" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Choose Files" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Select a filename" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "File Upload" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , title     =? "Insert Image" --> (customFloating $ W.RationalRect (0.1) (0.15) (0.8) (0.7))
  , className =? "Pavucontrol" --> doCenterFloat
  , title     =? "Question" --> doCenterFloat
--  , title     =? "Visual Studio Code"           --> doCenterFloat
  ] <+> namedScratchpadManageHook myScratchpads

myLayoutHook = avoidStruts $ spacingRaw False (Border myBdr 0 myBdr 0) True (Border 0 myBdr 0 myBdr) True $ layoutHook def 
myRmKey = [ 
          ("M-w")
        , ("M-e")
        , ("M-r")
        , ("M-S-w")
        , ("M-S-e")
        , ("M-S-r")
        ]
-- Prompt Config 
myXPConfig = def  
  { font = myFont
  , bgColor = myCol1
  , fgColor = myCol2
  , bgHLight = myCol2
  , fgHLight = myCol1
  , borderColor = myCol2
  , promptBorderWidth = 0
  , position = Top
  -- , position = CenteredAt 0.4 0.3 
  , height = 22
  , historySize = 256
  , historyFilter = id
  , defaultText = []
  , searchPredicate = fuzzyMatch
  , sorter = fuzzySort
  , autoComplete = Nothing
  , showCompletionOnTab = False
  , alwaysHighlight = True
  , maxComplRows = Just 1
  }
-- dmenu_run -fn "JetBrainsMono NF:weight=regular:size=10:antialias=true:autohint=true" -nb "#1a1b26" -nf "#c0caf5" -sb "#c0caf5" -sf "#1a1b26"
  
myKey =  [ ("M-S-<Return>", shellPrompt myXPConfig)
        , ("M-<Return>", spawn $ myTerminal)
        , ("M-q", spawn "xmonad --recompile && xmonad --restart")
        , ("M-r", spawn "xmonad --restart")
        , ("M-w", windows W.swapMaster)
        , ("M-S-z", spawn "slock")
        --, ("<XF86AudioMute>", spawn "amixer -D pulse sset Master toggle")
        --, ("<XF86AudioLowerVolume>", spawn "amixer -D pulse sset Master 4%-")
        --, ("<XF86AudioRaiseVolume>", spawn "amixer -D pulse sset Master 4%+")
        , ("M1-m", spawn "amixer -D pulse sset Master toggle")
        , ("M1-,", spawn "amixer -D pulse sset Master 4%-")
        , ("M1-.", spawn "amixer -D pulse sset Master 4%+")
        , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 2%-")
        , ("<XF86MonBrightnessUp>", spawn "brightnessctl set 2%+")
        , ("<Print>", spawn "flameshot full --path ~/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png")
        , ("M-<Print>", spawn "flameshot gui --path ~/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png")
        , ("M-S-<Print>", spawn "flameshot full --clipboard")
        , ("M-C-<Print>", spawn "flameshot gui --clipboard")
        , ("M-S-f", spawn "firefox")
        , ("M-S-g", spawn "firefox --private-window")
        -- , ("M-S-x", spawn "xournalpp")
        -- , ("M-S-l", spawn "libreoffice")
        , ("M-b", spawn "killall xmobar")
        , ("M-S-v", spawn "pavucontrol")
        , ("M1-<Return>", namedScratchpadAction myScratchpads "terminal")
        , ("M-S-n", namedScratchpadAction myScratchpads "network")
        , ("M-S-m", namedScratchpadAction myScratchpads "mplayer")
        , ("M-S-k", namedScratchpadAction myScratchpads "calculator")
        , ("M-S-s", namedScratchpadAction myScratchpads "ssr")
        , ("M-S-e", namedScratchpadAction myScratchpads "fm")
        -- , ("M-S-w", namedScratchpadAction myScratchpads "vscode")
        -- , ("M-S-w", namedScratchpadAction myScratchpads "sublime")
        , ("M-S-<KP_Add>", shiftTo Next nonNSP >> moveTo Next nonNSP)
        , ("M-S-<KP_Subtract>", shiftTo Prev nonNSP >> moveTo Prev nonNSP)
        ]
        where nonNSP = WSIs (return (\ws -> W.tag ws /= "nsp"))
              nonEmptyNonNSP = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "nsp"))

main = do
 xmproc0 <- spawnPipe "xmobar"
 xmonad $ docks $ def
  { handleEventHook = def <> Hacks.windowedFullscreenFixEventHook
  , manageHook = myManageHook 
  , startupHook = myStartupHook
  , workspaces = ["1","2","3","4","5","6","7","8","9"]
  , layoutHook = myLayoutHook
  , modMask = myModMask
  , terminal = myTerminal
  , logHook = dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn xmproc0 
                                          , ppTitle = xmobarColor myCol2 "" . shorten 80
                                          , ppCurrent = xmobarColor myCol5 "" . wrap "" "*" 
                                          , ppHidden = xmobarColor myCol5 "" . wrap "" "" 
                                          , ppHiddenNoWindows = xmobarColor myCol3 ""
                                          , ppUrgent = xmobarColor myCol1 myCol4 . wrap "!" "!" 
                                          , ppSep =  ""
                                          , ppSort = fmap (. filterOutWs [scratchpadWorkspaceTag]) (ppSort xmobarPP)
                                          , ppLayout = xmobarColor myCol2 "" .
                                          (\ x -> pad $ case x of
                                            "Spacing Tall" -> "[]="
                                            "Spacing Mirror Tall" -> "TTT"
                                            "Spacing Full" -> "[M]"
                                            _ -> x
                                          )
                                          }
  , borderWidth = myBorderWidth
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , focusFollowsMouse = myFocusFollowMouse
  , clickJustFocuses = myClickJustFocuses
  } `removeKeysP` myRmKey
    `additionalKeysP` myKey
