local MDT = MDT
local L = MDT.L
local dungeonIndex = 19
MDT.dungeonList[dungeonIndex] = L["Siege of Boralus"]

MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [2] = {
      zoomScale = 4.2999997138977,
      horizontalPan = 499.11205542634,
      verticalPan = 38.703272826513
    }
  }
}

local zones = { 1162 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = "SiegeOfBoralus" }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Siege of Boralus Sublevel"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 494, teeming = 319, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {}

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Scrimshaw Gutter",
    ["id"] = 133990,
    ["count"] = 1,
    ["health"] = 3644271,
    ["scale"] = 0.9,
    ["displayId"] = 83892,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [256616] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 729.88520031152,
        ["y"] = -458.8592545882,
        ["g"] = 9,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 742.862279776,
        ["y"] = -485.0321280043,
        ["g"] = 1,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 751.13613469958,
        ["y"] = -480.00464568685,
        ["g"] = 1,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 756.08004009671,
        ["y"] = -467.10349782422,
        ["g"] = 1,
        ["sublevel"] = 1
      },
      [5] = {
        ["x"] = 743.93758653062,
        ["y"] = -462.65067937942,
        ["g"] = 1,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 754.10416451831,
        ["y"] = -474.01625602185,
        ["g"] = 1,
        ["sublevel"] = 1
      },
      [7] = {
        ["x"] = 756.15274468272,
        ["y"] = -492.57476776469,
        ["g"] = 2,
        ["sublevel"] = 1
      },
      [8] = {
        ["x"] = 761.21752453393,
        ["y"] = -488.22712142544,
        ["g"] = 2,
        ["sublevel"] = 1
      },
      [9] = {
        ["x"] = 759.97787357555,
        ["y"] = -453.46124914472,
        ["g"] = 5,
        ["sublevel"] = 1
      },
      [10] = {
        ["x"] = 762.16753174733,
        ["y"] = -458.41897432714,
        ["g"] = 5,
        ["sublevel"] = 1
      },
      [11] = {
        ["x"] = 772.41691815168,
        ["y"] = -510.86238560146,
        ["g"] = 3,
        ["sublevel"] = 1
      },
      [12] = {
        ["x"] = 782.47220359294,
        ["y"] = -498.65921608008,
        ["g"] = 3,
        ["sublevel"] = 1
      },
      [13] = {
        ["x"] = 790.8689396282,
        ["y"] = -478.87486173446,
        ["g"] = 4,
        ["sublevel"] = 1
      },
      [14] = {
        ["x"] = 742.70645432231,
        ["y"] = -421.88505248383,
        ["g"] = 8,
        ["sublevel"] = 1
      },
      [15] = {
        ["x"] = 746.14850435435,
        ["y"] = -415.75142665114,
        ["g"] = 8,
        ["sublevel"] = 1
      },
      [16] = {
        ["x"] = 749.80391215964,
        ["y"] = -427.36705712073,
        ["g"] = 8,
        ["sublevel"] = 1
      },
      [17] = {
        ["x"] = 749.07915654367,
        ["y"] = -410.26845188979,
        ["g"] = 8,
        ["sublevel"] = 1
      },
      [18] = {
        ["x"] = 712.34127127325,
        ["y"] = -356.64600029581,
        ["g"] = 12,
        ["sublevel"] = 1
      },
      [19] = {
        ["x"] = 711.43512354662,
        ["y"] = -376.90327126065,
        ["g"] = 12,
        ["sublevel"] = 1
      },
      [20] = {
        ["x"] = 730.39980308802,
        ["y"] = -342.34186443997,
        ["g"] = 13,
        ["sublevel"] = 1
      },
      [21] = {
        ["x"] = 715.94879540669,
        ["y"] = -341.05763264764,
        ["g"] = 13,
        ["sublevel"] = 1
      },
      [22] = {
        ["x"] = 740.56186658913,
        ["y"] = -328.98150956819,
        ["g"] = 14,
        ["sublevel"] = 1
      },
      [23] = {
        ["x"] = 750.37096558459,
        ["y"] = -332.10533509212,
        ["g"] = 14,
        ["sublevel"] = 1
      },
      [24] = {
        ["x"] = 660.48921236401,
        ["y"] = -261.50487705456,
        ["g"] = 17,
        ["sublevel"] = 1
      },
      [25] = {
        ["x"] = 669.05581209753,
        ["y"] = -257.97875517181,
        ["g"] = 17,
        ["sublevel"] = 1
      },
      [26] = {
        ["x"] = 677.62713395002,
        ["y"] = -254.43645417394,
        ["g"] = 17,
        ["sublevel"] = 1
      },
      [27] = {
        ["x"] = 627.70226748533,
        ["y"] = -296.4818610721,
        ["g"] = 18,
        ["sublevel"] = 1
      },
      [28] = {
        ["x"] = 636.70886079497,
        ["y"] = -293.43149800552,
        ["g"] = 18,
        ["sublevel"] = 1
      },
      [29] = {
        ["x"] = 645.63982872006,
        ["y"] = -290.01757356582,
        ["g"] = 18,
        ["sublevel"] = 1
      }
    }
  },
  [2] = {
    ["name"] = "Blacktar Bomber",
    ["id"] = 129372,
    ["count"] = 6,
    ["health"] = 18221353,
    ["scale"] = 1.1,
    ["displayId"] = 84136,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [256639] = {},
      [256640] = {},
      [256660] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 727.94114898902,
        ["y"] = -413.06467558091,
        ["g"] = 10,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 740.48809166855,
        ["y"] = -443.91722655014,
        ["g"] = 7,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 747.66170230739,
        ["y"] = -442.83741113832,
        ["g"] = 7,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 781.73366862999,
        ["y"] = -458.2493103631,
        ["g"] = 6,
        ["sublevel"] = 1
      },
      [5] = {
        ["x"] = 779.17106248545,
        ["y"] = -448.69544013184,
        ["g"] = 6,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 703.3065663656,
        ["y"] = -355.6738383943,
        ["g"] = 12,
        ["sublevel"] = 1
      },
      [7] = {
        ["x"] = 693.24683432753,
        ["y"] = -318.88013689674,
        ["g"] = 15,
        ["sublevel"] = 1
      },
      [8] = {
        ["x"] = 743.98596248831,
        ["y"] = -320.47265574659,
        ["g"] = 14,
        ["sublevel"] = 1
      },
      [9] = {
        ["x"] = 754.15428291922,
        ["y"] = -323.72347573418,
        ["g"] = 14,
        ["sublevel"] = 1
      },
      [10] = {
        ["x"] = 732.18266203007,
        ["y"] = -276.63364455167,
        ["sublevel"] = 1
      },
      [11] = {
        ["x"] = 664.32147170812,
        ["y"] = -271.83324543212,
        ["g"] = 17,
        ["sublevel"] = 1
      },
      [12] = {
        ["x"] = 632.46216217812,
        ["y"] = -228.23888610425,
        ["g"] = 19,
        ["sublevel"] = 1
      },
      [13] = {
        ["x"] = 641.66286498881,
        ["y"] = -233.6259504117,
        ["g"] = 19,
        ["sublevel"] = 1
      },
      [14] = {
        ["x"] = 718.65421441476,
        ["y"] = -412.6009519278,
        ["g"] = 10,
        ["sublevel"] = 1
      },
      [15] = {
        ["x"] = 773.30864198512,
        ["y"] = -377.11535274485,
        ["g"] = 11,
        ["sublevel"] = 1
      },
      [16] = {
        ["x"] = 762.42972606766,
        ["y"] = -374.40471812745,
        ["g"] = 11,
        ["sublevel"] = 1
      }
    }
  },
  [3] = {
    ["name"] = "Scrimshaw Enforcer",
    ["id"] = 129374,
    ["count"] = 5,
    ["health"] = 18221353,
    ["scale"] = 1.1,
    ["displayId"] = 86006,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [256627] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 723.02501351034,
        ["y"] = -458.34870471798,
        ["g"] = 9,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 745.45708147747,
        ["y"] = -474.14093816701,
        ["g"] = 1,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 777.67432570927,
        ["y"] = -504.36050317528,
        ["g"] = 3,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 795.00361891084,
        ["y"] = -486.35567649019,
        ["g"] = 4,
        ["sublevel"] = 1
      },
      [5] = {
        ["x"] = 755.03798273018,
        ["y"] = -421.08365246135,
        ["g"] = 8,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 702.90705604104,
        ["y"] = -366.04282865103,
        ["g"] = 12,
        ["sublevel"] = 1
      },
      [7] = {
        ["x"] = 726.31322788869,
        ["y"] = -317.16223288986,
        ["sublevel"] = 1
      },
      [8] = {
        ["x"] = 716.10295285277,
        ["y"] = -437.55727710048,
        ["sublevel"] = 1
      }
    }
  },
  [4] = {
    ["name"] = "Irontide Waveshaper",
    ["id"] = 129370,
    ["count"] = 6,
    ["health"] = 14577080,
    ["scale"] = 1.1,
    ["displayId"] = 79077,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [256957] = {
        ["interruptible"] = true
      },
      [257063] = {
        ["interruptible"] = true
      }
    },
    ["clones"] = {
      [1] = {
        ["x"] = 723.82652830442,
        ["y"] = -465.60344895333,
        ["g"] = 9,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 764.59190400689,
        ["y"] = -464.5448592244,
        ["g"] = 5,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 792.33946614387,
        ["y"] = -471.09259407638,
        ["g"] = 4,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 758.15459557258,
        ["y"] = -413.65482326023,
        ["g"] = 8,
        ["sublevel"] = 1
      },
      [5] = {
        ["x"] = 702.19662528312,
        ["y"] = -376.70528674573,
        ["g"] = 12,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 701.26515360449,
        ["y"] = -313.01634683739,
        ["g"] = 15,
        ["sublevel"] = 1
      },
      [7] = {
        ["x"] = 682.25946882323,
        ["y"] = -263.1591813788,
        ["g"] = 17,
        ["sublevel"] = 1
      },
      [8] = {
        ["x"] = 623.59983434047,
        ["y"] = -286.99349565484,
        ["g"] = 18,
        ["sublevel"] = 1
      },
      [9] = {
        ["x"] = 650.32470660058,
        ["y"] = -227.50946057393,
        ["g"] = 19,
        ["sublevel"] = 1
      },
      [10] = {
        ["x"] = 582.24452216694,
        ["y"] = -225.40021718922,
        ["g"] = 22,
        ["sublevel"] = 1
      },
      [11] = {
        ["x"] = 460.38023900096,
        ["y"] = -321.474758654,
        ["g"] = 26,
        ["sublevel"] = 1
      },
      [12] = {
        ["x"] = 380.15897145364,
        ["y"] = -317.55128326818,
        ["g"] = 28,
        ["sublevel"] = 1
      },
      [13] = {
        ["x"] = 199.94929788675,
        ["y"] = -102.98048096862,
        ["g"] = 39,
        ["sublevel"] = 1
      },
      [14] = {
        ["x"] = 158.57356147874,
        ["y"] = -146.12828177599,
        ["g"] = 38,
        ["sublevel"] = 1
      },
      [15] = {
        ["x"] = 728.73699467712,
        ["y"] = -404.05883754001,
        ["g"] = 10,
        ["sublevel"] = 1
      }
    }
  },
  [5] = {
    ["name"] = "Irontide Raider",
    ["id"] = 129369,
    ["count"] = 10,
    ["health"] = 29154165,
    ["scale"] = 1.2,
    ["displayId"] = 84134,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [257170] = {},
      [272662] = {},
      [275775] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 719.82939497886,
        ["y"] = -403.61024248811,
        ["g"] = 10,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 775.98223204984,
        ["y"] = -481.8974217441,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 765.03399444513,
        ["y"] = -391.90438751257,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 727.05914341708,
        ["y"] = -285.73307413136,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 727.05914341708,
            ["y"] = -285.73307413136
          },
          [2] = {
            ["x"] = 728.35683090952,
            ["y"] = -297.96178663288
          },
          [3] = {
            ["x"] = 721.02923781858,
            ["y"] = -303.3089371617
          },
          [4] = {
            ["x"] = 709.74078074098,
            ["y"] = -315.19156082805
          },
          [5] = {
            ["x"] = 703.60141513968,
            ["y"] = -320.73675984059
          },
          [6] = {
            ["x"] = 709.74078074098,
            ["y"] = -315.19156082805
          },
          [7] = {
            ["x"] = 721.02923781858,
            ["y"] = -303.3089371617
          },
          [8] = {
            ["x"] = 728.35683090952,
            ["y"] = -297.96178663288
          }
        }
      },
      [5] = {
        ["x"] = 672.90873254286,
        ["y"] = -268.0256513187,
        ["g"] = 17,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 632.76741603704,
        ["y"] = -283.32326693446,
        ["g"] = 18,
        ["sublevel"] = 1
      },
      [7] = {
        ["x"] = 633.8092755543,
        ["y"] = -203.45700733628,
        ["g"] = 20,
        ["sublevel"] = 1
      },
      [8] = {
        ["x"] = 567.04656415064,
        ["y"] = -276.24332911522,
        ["sublevel"] = 1
      },
      [9] = {
        ["x"] = 776.19007163283,
        ["y"] = -367.22441729683,
        ["g"] = 11,
        ["sublevel"] = 1
      },
      [10] = {
        ["x"] = 207.14669876209,
        ["y"] = -143.78194332134,
        ["g"] = 44,
        ["sublevel"] = 1
      },
      [11] = {
        ["x"] = 155.30013335796,
        ["y"] = -89.125121113435,
        ["g"] = 40,
        ["sublevel"] = 1
      }
    }
  },
  [6] = {
    ["name"] = "Riptide Shredder",
    ["id"] = 129371,
    ["count"] = 6,
    ["health"] = 18221353,
    ["scale"] = 1,
    ["displayId"] = 86085,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [256709] = {},
      [256866] = {},
      [257270] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 711.94298519096,
        ["y"] = -366.75473185775,
        ["g"] = 12,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 723.17625434054,
        ["y"] = -341.50573516969,
        ["g"] = 13,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 684.30508617149,
        ["y"] = -320.39498767183,
        ["g"] = 15,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 641.92207424257,
        ["y"] = -280.19439429506,
        ["g"] = 18,
        ["sublevel"] = 1
      }
    }
  },
  [7] = {
    ["name"] = "Snarling Dockhound",
    ["id"] = 129640,
    ["count"] = 4,
    ["health"] = 18221353,
    ["scale"] = 0.8,
    ["displayId"] = 30222,
    ["creatureType"] = "Beast",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true
    },
    ["clones"] = {
      [1] = {
        ["x"] = 746.81596186465,
        ["y"] = -261.63909317561,
        ["g"] = 16,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 754.26918135219,
        ["y"] = -267.95231412865,
        ["g"] = 16,
        ["sublevel"] = 1
      }
    }
  },
  [8] = {
    ["name"] = "Irontide Curseblade",
    ["id"] = 135258,
    ["count"] = 1,
    ["health"] = 3644271,
    ["scale"] = 1,
    ["displayId"] = 79068,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [257168] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 628.68615484,
        ["y"] = -193.10454513406,
        ["g"] = 20,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 622.45948519492,
        ["y"] = -200.7401549958,
        ["g"] = 20,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 644.83939499459,
        ["y"] = -200.36182970881,
        ["g"] = 20,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 638.0803552082,
        ["y"] = -192.71366941095,
        ["g"] = 20,
        ["sublevel"] = 1
      },
      [5] = {
        ["x"] = 590.11919487457,
        ["y"] = -242.42794230175,
        ["g"] = 21,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 595.8602226992,
        ["y"] = -248.05418149609,
        ["g"] = 21,
        ["sublevel"] = 1
      },
      [7] = {
        ["x"] = 599.87537112698,
        ["y"] = -255.01367598433,
        ["g"] = 21,
        ["sublevel"] = 1
      },
      [8] = {
        ["x"] = 603.70042455352,
        ["y"] = -262.15647947088,
        ["g"] = 21,
        ["sublevel"] = 1
      },
      [9] = {
        ["x"] = 592.03971903005,
        ["y"] = -221.6702582955,
        ["g"] = 22,
        ["sublevel"] = 1
      },
      [10] = {
        ["x"] = 453.84334132502,
        ["y"] = -329.18127765457,
        ["g"] = 26,
        ["sublevel"] = 1
      },
      [11] = {
        ["x"] = 480.04564748418,
        ["y"] = -319.70391097817,
        ["g"] = 26,
        ["sublevel"] = 1
      },
      [12] = {
        ["x"] = 361.95239280639,
        ["y"] = -315.78870167954,
        ["g"] = 28,
        ["sublevel"] = 1
      },
      [13] = {
        ["x"] = 372.01790413121,
        ["y"] = -311.72420114754,
        ["g"] = 28,
        ["sublevel"] = 1
      }
    }
  },
  [9] = {
    ["name"] = "Irontide Powdershot",
    ["id"] = 137521,
    ["count"] = 4,
    ["health"] = 3644271,
    ["scale"] = 1,
    ["displayId"] = 85144,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [257641] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 764.58148440606,
        ["y"] = -364.72314632334,
        ["g"] = 11,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 581.97097426836,
        ["y"] = -268.45581137766,
        ["g"] = 23,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 576.76693588961,
        ["y"] = -258.33212174819,
        ["g"] = 23,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 537.13949201961,
        ["y"] = -241.77114589216,
        ["g"] = 24,
        ["sublevel"] = 1
      },
      [5] = {
        ["x"] = 470.7985472751,
        ["y"] = -317.43365551295,
        ["g"] = 26,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 360.85133399562,
        ["y"] = -326.10199347014,
        ["g"] = 28,
        ["sublevel"] = 1
      }
    }
  },
  [10] = {
    ["name"] = "Ashvane Commander",
    ["id"] = 128969,
    ["count"] = 10,
    ["health"] = 29154165,
    ["scale"] = 1.2,
    ["displayId"] = 84067,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [275826] = {},
      [454437] = {},
      [454438] = {},
      [454439] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 641.38939764551,
        ["y"] = -222.081270134,
        ["g"] = 19,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 586.36087280368,
        ["y"] = -258.96876363102,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 586.36087280368,
            ["y"] = -258.96876363102
          },
          [2] = {
            ["x"] = 569.63111918083,
            ["y"] = -266.89880169713
          },
          [3] = {
            ["x"] = 586.36087280368,
            ["y"] = -258.96876363102
          }
        }
      },
      [3] = {
        ["x"] = 370.41982341396,
        ["y"] = -322.14795554033,
        ["g"] = 28,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 192.23088982767,
        ["y"] = -108.82233035783,
        ["g"] = 39,
        ["sublevel"] = 1
      },
      [5] = {
        ["x"] = 161.60751505956,
        ["y"] = -154.56553526662,
        ["g"] = 38,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 346.70496491399,
        ["y"] = -240.54294757977,
        ["g"] = 29,
        ["sublevel"] = 1
      },
      [7] = {
        ["x"] = 212.68124022129,
        ["y"] = -135.13881612872,
        ["g"] = 44,
        ["sublevel"] = 1
      }
    }
  },
  [11] = {
    ["name"] = "Ashvane Spotter",
    ["id"] = 138255,
    ["count"] = 4,
    ["health"] = 18221353,
    ["scale"] = 1,
    ["displayId"] = 86436,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [272140] = {},
      [272418] = {},
      [272421] = {},
      [272422] = {},
      [272471] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 473.63368427664,
        ["y"] = -280.14502721353,
        ["g"] = 25,
        ["sublevel"] = 1
      }
    }
  },
  [12] = {
    ["name"] = "Ashvane Spotter",
    ["id"] = 135263,
    ["count"] = 4,
    ["health"] = 18221353,
    ["scale"] = 1.1,
    ["displayId"] = 86436,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [272418] = {},
      [272421] = {},
      [272422] = {},
      [272471] = {}
    },
    ["clones"] = {
      [2] = {
        ["x"] = 193.64627808553,
        ["y"] = -172.35099883514,
        ["g"] = 37,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 356.48670836472,
        ["y"] = -237.12332781293,
        ["g"] = 29,
        ["sublevel"] = 1
      }
    }
  },
  [13] = {
    ["name"] = "Ashvane Deckhand",
    ["id"] = 138464,
    ["count"] = 2,
    ["health"] = 9110677,
    ["scale"] = 1,
    ["displayId"] = 84385,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [268230] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 351.57160606939,
        ["y"] = -227.08815838378,
        ["g"] = 29,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 334.08138258774,
        ["y"] = -233.94855359186,
        ["g"] = 29,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 343.30161695695,
        ["y"] = -230.74718379935,
        ["g"] = 29,
        ["sublevel"] = 1
      }
    }
  },
  [14] = {
    ["name"] = "Ashvane Cannoneer",
    ["id"] = 138465,
    ["count"] = 8,
    ["health"] = 18221353,
    ["scale"] = 1,
    ["displayId"] = 88542,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [268260] = {},
      [281388] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 335.89503408748,
        ["y"] = -243.00562558779,
        ["g"] = 29,
        ["sublevel"] = 1
      }
    }
  },
  [15] = {
    ["name"] = "Bilge Rat Pillager",
    ["id"] = 135241,
    ["count"] = 7,
    ["health"] = 18221353,
    ["scale"] = 1,
    ["displayId"] = 52277,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [454440] = {
        ["interruptible"] = true
      }
    },
    ["clones"] = {
      [1] = {
        ["x"] = 233.9764530647,
        ["y"] = -182.65105956826,
        ["g"] = 30,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 286.37396855787,
        ["y"] = -260.46960709065,
        ["g"] = 33,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 250.56620460129,
        ["y"] = -243.50418439078,
        ["g"] = 32,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 255.17355426064,
        ["y"] = -235.23016179935,
        ["g"] = 32,
        ["sublevel"] = 1
      },
      [5] = {
        ["x"] = 188.59633199906,
        ["y"] = -217.45792828087,
        ["g"] = 36,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 209.81957744393,
        ["y"] = -219.92903809732,
        ["g"] = 35,
        ["sublevel"] = 1
      },
      [7] = {
        ["x"] = 228.67338160671,
        ["y"] = -218.66836590709,
        ["g"] = 35,
        ["sublevel"] = 1
      }
    }
  },
  [16] = {
    ["name"] = "Bilge Rat Buccaneer",
    ["id"] = 129366,
    ["count"] = 4,
    ["health"] = 18221353,
    ["scale"] = 1,
    ["displayId"] = 81424,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [272546] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 232.20073586579,
        ["y"] = -172.78323779966,
        ["g"] = 30,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 236.7661718324,
        ["y"] = -201.2944896819,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 271.04846450506,
        ["y"] = -212.55973675926,
        ["g"] = 31,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 265.27124652483,
        ["y"] = -221.76438434646,
        ["g"] = 31,
        ["sublevel"] = 1
      },
      [5] = {
        ["x"] = 290.81846996425,
        ["y"] = -251.21330506993,
        ["g"] = 33,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 235.15062279982,
        ["y"] = -271.05995480508,
        ["g"] = 34,
        ["sublevel"] = 1
      },
      [7] = {
        ["x"] = 247.9465100594,
        ["y"] = -267.1268256251,
        ["g"] = 34,
        ["sublevel"] = 1
      },
      [8] = {
        ["x"] = 243.18466095671,
        ["y"] = -276.06622430027,
        ["g"] = 34,
        ["sublevel"] = 1
      },
      [9] = {
        ["x"] = 219.81516104527,
        ["y"] = -250.04947361512,
        ["sublevel"] = 1
      },
      [10] = {
        ["x"] = 192.40641641181,
        ["y"] = -208.97951983278,
        ["g"] = 36,
        ["sublevel"] = 1
      },
      [11] = {
        ["x"] = 182.92065509484,
        ["y"] = -210.20634774757,
        ["g"] = 36,
        ["sublevel"] = 1
      }
    }
  },
  [17] = {
    ["name"] = "Bilge Rat Demolisher",
    ["id"] = 135245,
    ["count"] = 10,
    ["health"] = 36442707,
    ["scale"] = 1.2,
    ["displayId"] = 68059,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [257169] = {},
      [272711] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 247.07452309044,
        ["y"] = -185.81996812982,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 283.64693531101,
        ["y"] = -230.78120407378,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 283.64693531101,
            ["y"] = -230.78120407378
          },
          [2] = {
            ["x"] = 279.93005126473,
            ["y"] = -242.72839430688
          },
          [3] = {
            ["x"] = 270.98614768674,
            ["y"] = -253.90827804098
          },
          [4] = {
            ["x"] = 263.00054323534,
            ["y"] = -254.86654307472
          },
          [5] = {
            ["x"] = 251.82065950125,
            ["y"] = -249.75574224775
          },
          [6] = {
            ["x"] = 260.28542203916,
            ["y"] = -230.74997910658
          },
          [7] = {
            ["x"] = 270.82645673528,
            ["y"] = -222.92406560664
          }
        }
      },
      [3] = {
        ["x"] = 233.54493917569,
        ["y"] = -245.89264377302,
        ["sublevel"] = 1
      }
    }
  },
  [18] = {
    ["name"] = "Bilge Rat Tempest",
    ["id"] = 129367,
    ["count"] = 7,
    ["health"] = 14577080,
    ["scale"] = 1,
    ["displayId"] = 80475,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [272571] = {
        ["interruptible"] = true
      },
      [272581] = {
        ["interruptible"] = true
      }
    },
    ["clones"] = {
      [1] = {
        ["x"] = 260.92945469704,
        ["y"] = -212.72024070553,
        ["g"] = 31,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 239.3218806803,
        ["y"] = -262.79955896091,
        ["g"] = 34,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 259.10226199843,
        ["y"] = -243.50641796439,
        ["g"] = 32,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 218.89505760674,
        ["y"] = -219.45247815591,
        ["g"] = 35,
        ["sublevel"] = 1
      }
    }
  },
  [19] = {
    ["name"] = "Bilge Rat Cutthroat",
    ["id"] = 137511,
    ["count"] = 4,
    ["health"] = 14577083,
    ["scale"] = 1,
    ["displayId"] = 80319,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [272588] = {
        ["interruptible"] = true
      }
    },
    ["clones"] = {
      [1] = {
        ["x"] = 214.57822865444,
        ["y"] = -228.38148489769,
        ["g"] = 35,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 224.60292939069,
        ["y"] = -227.92658742623,
        ["g"] = 35,
        ["sublevel"] = 1
      }
    }
  },
  [20] = {
    ["name"] = "Ashvane Invader",
    ["id"] = 137516,
    ["count"] = 4,
    ["health"] = 18221353,
    ["scale"] = 1,
    ["displayId"] = 79889,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [275835] = {},
      [275836] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 186.1451870121,
        ["y"] = -101.5487587377,
        ["g"] = 39,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 150.78896442161,
        ["y"] = -78.153573419584,
        ["g"] = 40,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 149.33737894548,
        ["y"] = -144.76845586958,
        ["g"] = 38,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 152.61178569607,
        ["y"] = -154.34351012004,
        ["g"] = 38,
        ["sublevel"] = 1
      }
    }
  },
  [21] = {
    ["name"] = "Ashvane Destroyer",
    ["id"] = 137517,
    ["count"] = 4,
    ["health"] = 18221353,
    ["scale"] = 1,
    ["displayId"] = 82852,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [272888] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 193.55491948095,
        ["y"] = -95.653215752685,
        ["g"] = 39,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 156.46601795284,
        ["y"] = -163.28088880706,
        ["g"] = 38,
        ["sublevel"] = 1
      }
    }
  },
  [22] = {
    ["name"] = "Irontide Waveshaper",
    ["id"] = 144071,
    ["count"] = 6,
    ["health"] = 14577080,
    ["scale"] = 1,
    ["displayId"] = 79077,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [256957] = {
        ["interruptible"] = true
      },
      [257063] = {
        ["interruptible"] = true
      }
    },
    ["clones"] = {
      [16] = {
        ["x"] = 545.50075520104,
        ["y"] = -237.69512651494,
        ["g"] = 24,
        ["sublevel"] = 1
      }
    }
  },
  [23] = {
    ["name"] = "Irontide Powdershot",
    ["id"] = 138254,
    ["count"] = 4,
    ["health"] = 3644271,
    ["scale"] = 1,
    ["displayId"] = 85144,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [257641] = {}
    },
    ["clones"] = {
      [7] = {
        ["x"] = 464.38022232676,
        ["y"] = -279.11588347673,
        ["g"] = 25,
        ["sublevel"] = 1
      },
      [8] = {
        ["x"] = 467.50355154324,
        ["y"] = -287.64299612648,
        ["g"] = 25,
        ["sublevel"] = 1
      },
      [9] = {
        ["x"] = 472.47080923716,
        ["y"] = -296.30421042528,
        ["g"] = 25,
        ["sublevel"] = 1
      },
      [10] = {
        ["x"] = 460.0002458275,
        ["y"] = -269.74064208745,
        ["g"] = 25,
        ["sublevel"] = 1
      }
    }
  },
  [24] = {
    ["name"] = "Ashvane Sniper",
    ["id"] = 128967,
    ["count"] = 4,
    ["health"] = 18221353,
    ["scale"] = 1,
    ["displayId"] = 82843,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [272528] = {},
      [272542] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 178.6521968409,
        ["y"] = -170.6134060014,
        ["g"] = 37,
        ["sublevel"] = 1
      },
      [2] = {
        ["x"] = 185.21555774706,
        ["y"] = -176.34211056043,
        ["g"] = 37,
        ["sublevel"] = 1
      },
      [3] = {
        ["x"] = 200.69665915956,
        ["y"] = -187.91928054872,
        ["g"] = 37,
        ["sublevel"] = 1
      },
      [4] = {
        ["x"] = 192.71786900203,
        ["y"] = -182.2891180212,
        ["g"] = 37,
        ["sublevel"] = 1
      },
      [5] = {
        ["x"] = 146.34628897344,
        ["y"] = -87.592399108426,
        ["g"] = 40,
        ["sublevel"] = 1
      },
      [6] = {
        ["x"] = 160.51681109839,
        ["y"] = -81.766038756887,
        ["g"] = 40,
        ["sublevel"] = 1
      }
    }
  },
  [25] = {
    ["name"] = "Irontide Curseblade",
    ["id"] = 138247,
    ["count"] = 1,
    ["health"] = 3644271,
    ["scale"] = 1,
    ["displayId"] = 79068,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [257168] = {}
    },
    ["clones"] = {
      [14] = {
        ["x"] = 535.69688658489,
        ["y"] = -251.27517817228,
        ["g"] = 24,
        ["sublevel"] = 1
      },
      [15] = {
        ["x"] = 553.12643522348,
        ["y"] = -243.14817940776,
        ["g"] = 24,
        ["sublevel"] = 1
      },
      [16] = {
        ["x"] = 544.64564409149,
        ["y"] = -247.9243500473,
        ["g"] = 24,
        ["sublevel"] = 1
      },
      [17] = {
        ["x"] = 475.9102331631,
        ["y"] = -353.96718372909,
        ["g"] = 27,
        ["sublevel"] = 1
      },
      [18] = {
        ["x"] = 467.3948733173,
        ["y"] = -356.81164084427,
        ["g"] = 27,
        ["sublevel"] = 1
      },
      [19] = {
        ["x"] = 469.96776598343,
        ["y"] = -346.36514714077,
        ["g"] = 27,
        ["sublevel"] = 1
      },
      [20] = {
        ["x"] = 484.95479969376,
        ["y"] = -351.36928252292,
        ["g"] = 27,
        ["sublevel"] = 1
      },
      [21] = {
        ["x"] = 479.38311738089,
        ["y"] = -344.36709292183,
        ["g"] = 27,
        ["sublevel"] = 1
      },
      [22] = {
        ["x"] = 493.84283291152,
        ["y"] = -348.49249339179,
        ["g"] = 27,
        ["sublevel"] = 1
      },
      [23] = {
        ["x"] = 489.06871672022,
        ["y"] = -341.51686296883,
        ["g"] = 27,
        ["sublevel"] = 1
      },
      [24] = {
        ["x"] = 424.97553853937,
        ["y"] = -316.86962266285,
        ["sublevel"] = 1
      },
      [25] = {
        ["x"] = 408.83768462574,
        ["y"] = -298.07157352162,
        ["sublevel"] = 1
      },
      [26] = {
        ["x"] = 379.92209634629,
        ["y"] = -364.4704156759,
        ["sublevel"] = 1
      },
      [27] = {
        ["x"] = 403.54859916106,
        ["y"] = -365.12028537276,
        ["sublevel"] = 1
      },
      [28] = {
        ["x"] = 386.12417004844,
        ["y"] = -381.55493650894,
        ["sublevel"] = 1
      },
      [29] = {
        ["x"] = 409.29056735228,
        ["y"] = -380.74003196673,
        ["sublevel"] = 1
      },
      [30] = {
        ["x"] = 391.49385719467,
        ["y"] = -398.16549280184,
        ["sublevel"] = 1
      },
      [31] = {
        ["x"] = 414.91908238876,
        ["y"] = -398.93108493148,
        ["sublevel"] = 1
      },
      [32] = {
        ["x"] = 317.71192357736,
        ["y"] = -230.07291450627,
        ["sublevel"] = 1
      },
      [33] = {
        ["x"] = 319.43010617788,
        ["y"] = -241.6493382827,
        ["sublevel"] = 1
      },
      [34] = {
        ["x"] = 369.83834662197,
        ["y"] = -218.21621314032,
        ["sublevel"] = 1
      },
      [35] = {
        ["x"] = 362.67417000256,
        ["y"] = -211.18679873201,
        ["sublevel"] = 1
      },
      [36] = {
        ["x"] = 371.07501097629,
        ["y"] = -227.9512629476,
        ["sublevel"] = 1
      }
    }
  },
  [26] = {
    ["name"] = "Chopper Redhook",
    ["id"] = 128650,
    ["count"] = 0,
    ["health"] = 101901082,
    ["scale"] = 0.8,
    ["displayId"] = 84821,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2654,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [256867] = {},
      [257326] = {},
      [257459] = {},
      [257650] = {},
      [272662] = {},
      [273681] = {},
      [273716] = {},
      [274002] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 635.54480864854,
        ["y"] = -262.86202672769,
        ["sublevel"] = 1
      }
    }
  },
  [27] = {
    ["name"] = "Irontide Cleaver",
    ["id"] = 129879,
    ["count"] = 0,
    ["health"] = 15184460,
    ["scale"] = 1,
    ["displayId"] = 81286,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [257288] = {},
      [257292] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 638.92712892458,
        ["y"] = -252.10174282227,
        ["sublevel"] = 1
      }
    }
  },
  [28] = {
    ["name"] = "Irontide Powdershot",
    ["id"] = 129928,
    ["count"] = 0,
    ["health"] = 3036892,
    ["scale"] = 1,
    ["displayId"] = 85144,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [257641] = {}
    },
    ["clones"] = {
      [11] = {
        ["x"] = 625.41899287047,
        ["y"] = -258.81737696511,
        ["sublevel"] = 1
      },
      [12] = {
        ["x"] = 719.86517258984,
        ["y"] = -276.67549621503,
        ["sublevel"] = 1
      }
    }
  },
  [29] = {
    ["name"] = "Dread Captain Lockwood",
    ["id"] = 129208,
    ["count"] = 0,
    ["health"] = 89163448,
    ["scale"] = 1.6,
    ["displayId"] = 88579,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2173,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [181089] = {},
      [268752] = {},
      [269029] = {},
      [272421] = {},
      [272471] = {},
      [273470] = {},
      [280389] = {},
      [463182] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 337.61002112208,
        ["y"] = -194.64471246241,
        ["sublevel"] = 1
      }
    }
  },
  [30] = {
    ["name"] = "Ashvane Deckhand",
    ["id"] = 136483,
    ["count"] = 0,
    ["health"] = 6998701,
    ["scale"] = 1,
    ["displayId"] = 84385,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2173,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [268230] = {}
    },
    ["clones"] = {
      [4] = {
        ["x"] = 322.54602661606,
        ["y"] = -175.27568362909,
        ["sublevel"] = 1
      }
    }
  },
  [31] = {
    ["name"] = "Ashvane Cannoneer",
    ["id"] = 136549,
    ["count"] = 0,
    ["health"] = 13997402,
    ["scale"] = 1,
    ["displayId"] = 82852,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2173,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true
    },
    ["spells"] = {
      [268260] = {},
      [268963] = {},
      [268976] = {},
      [281388] = {}
    },
    ["clones"] = {
      [2] = {
        ["x"] = 349.41805024837,
        ["y"] = -169.59881145297,
        ["sublevel"] = 1
      }
    }
  },
  [32] = {
    ["name"] = "Hadal Darkfathom",
    ["id"] = 128651,
    ["count"] = 0,
    ["health"] = 145572975,
    ["scale"] = 1.5,
    ["displayId"] = 67541,
    ["creatureType"] = "Giant",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2134,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true
    },
    ["spells"] = {
      [257862] = {},
      [257868] = {},
      [257882] = {},
      [257883] = {},
      [276068] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 131.44758205836,
        ["y"] = -115.28967974166,
        ["sublevel"] = 1
      }
    }
  },
  [33] = {
    ["name"] = "Viqgoth",
    ["id"] = 128652,
    ["count"] = 0,
    ["health"] = 454915546,
    ["scale"] = 1.5,
    ["displayId"] = 87990,
    ["creatureType"] = "Aberration",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2140,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true
    },
    ["spells"] = {
      [269456] = {},
      [269484] = {},
      [269984] = {},
      [270187] = {},
      [270484] = {},
      [274991] = {},
      [275014] = {},
      [277535] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 70.838531556852,
        ["y"] = -155.72465904103,
        ["sublevel"] = 1
      }
    }
  },
  [34] = {
    ["name"] = "Gripping Terror",
    ["id"] = 137405,
    ["count"] = 0,
    ["health"] = 21835946,
    ["scale"] = 1.1,
    ["displayId"] = 88448,
    ["creatureType"] = "Aberration",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2140,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true
    },
    ["spells"] = {},
    ["clones"] = {
      [1] = {
        ["x"] = 52.647493468106,
        ["y"] = -135.52934567108,
        ["sublevel"] = 1
      }
    }
  },
  [35] = {
    ["name"] = "Demolishing Terror",
    ["id"] = 137614,
    ["count"] = 0,
    ["health"] = 33593764,
    ["scale"] = 1.1,
    ["displayId"] = 86691,
    ["creatureType"] = "Aberration",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2140,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true
    },
    ["spells"] = {
      [269266] = {},
      [270590] = {}
    },
    ["clones"] = {
      [1] = {
        ["x"] = 68.797824144108,
        ["y"] = -181.89195829661,
        ["sublevel"] = 1
      }
    }
  }
}
