(eval-after-load "cedet"
  '(progn
     (ede-cpp-root-project "Atlantis"
                           :name "Atlantis"
                           :file "~/Projects/atlantis/Project.ede"
                           :include-path '("/atassess/include"
                                           "/atecology/include"
                                           "/ateconomic/include"
                                           "/atFileConvert/include"
                                           "/atlantismain"
                                           "/atlantismain/include"
                                           "/atlantisUtil/include"
                                           "/atlink"
                                           "/atlink/include"
                                           "/atmanage/include"
                                           "/atphysics/include"
                                           "/sjwlib/include")
                           :system-include-path '("/usr/include"
                                                  "/usr/local/include"
                                                  "/usr/include/libxml2"
                                                  "/usr/include/nanohttp-1.0"
                                                  "/usr/include/libcsoap-1.0"))
     (ede-cpp-root-project "Atlantis-integration"
                           :name "Atlantis-integration"
                           :file "~/Projects/atlantis-integration-dev/Project.ede"
                           :include-path '("/atassess/include"
                                           "/atecology/include"
                                           "/ateconomic/include"
                                           "/atFileConvert/include"
                                           "/atlantismain"
                                           "/atlantismain/include"
                                           "/atlantisUtil/include"
                                           "/atlink/include"
                                           "/atmanage/include"
                                           "/atphysics/include"
                                           "/sjwlib/include")
                           :system-include-path '("/usr/include"
                                                  "/usr/local/include"
                                                  "/usr/include/libxml2"
                                                  "/usr/include/nanohttp-1.0"
                                                  "/usr/include/libcsoap-1.0"))))
