import Foundation

enum RecipeLibrary {

    static let all: [Recipe] = [
        classicV60,
        icedV60,
        aeropressClassic,
        aeropressInverted,
        hoffmannV60,
        hoffmannAeroPress,
        hoffmannIcedV60,
        hoffmannFrenchPress
    ]

    static func recipes(for method: BrewMethod) -> [Recipe] {
        all.filter { $0.method == method }
    }

    // MARK: – V60 Classic (15g / 250ml)
    static let classicV60 = Recipe(
        id: UUID(uuidString: "00000001-0000-0000-0000-000000000001")!,
        name: "Classic V60",
        method: .v60,
        steps: [
            BrewStep(name: "Rinse Filter",
                     description: "Place filter in V60. Pour hot water through to rinse paper and preheat vessel. Discard rinse water.",
                     durationSeconds: 0),
            BrewStep(name: "Add Coffee",
                     description: "Add 15g of medium-fine ground coffee. Gently shake to level the bed.",
                     durationSeconds: 0),
            BrewStep(name: "Bloom",
                     description: "Start timer. Pour 50ml of water in a spiral from center outward. Ensure all grounds are saturated.",
                     durationSeconds: 45,
                     pourAmountMl: 50),
            BrewStep(name: "First Pour",
                     description: "Pour 100ml of water in slow, steady circles. Keep the water level consistent.",
                     durationSeconds: 30,
                     pourAmountMl: 100),
            BrewStep(name: "Second Pour",
                     description: "Pour remaining 100ml in the same circular motion. Aim for the center, then spiral outward.",
                     durationSeconds: 30,
                     pourAmountMl: 100),
            BrewStep(name: "Draw Down",
                     description: "Wait for the coffee to fully drain through the filter. Total brew time should be around 3 minutes.",
                     durationSeconds: 0)
        ],
        defaultCoffeeGrams: 15,
        defaultWaterMl: 250,
        difficulty: .easy,
        waterTemperatureCelsius: 93
    )

    // MARK: – V60 Iced Coffee (18g / 125ml hot + ice)
    static let icedV60 = Recipe(
        id: UUID(uuidString: "00000001-0000-0000-0000-000000000002")!,
        name: "V60 Iced Coffee",
        method: .v60,
        steps: [
            BrewStep(name: "Prepare Ice",
                     description: "Add 125g of ice to your serving vessel. Place V60 with rinsed filter on top.",
                     durationSeconds: 0),
            BrewStep(name: "Rinse Filter",
                     description: "Pour hot water through to rinse paper and preheat the V60. Discard rinse water.",
                     durationSeconds: 0),
            BrewStep(name: "Add Coffee",
                     description: "Add 18g of medium-fine ground coffee. Gently level the bed.",
                     durationSeconds: 0),
            BrewStep(name: "Bloom",
                     description: "Start timer. Pour 36ml of water in a spiral. Saturate all grounds.",
                     durationSeconds: 45,
                     pourAmountMl: 36),
            BrewStep(name: "First Pour",
                     description: "Pour 80ml of water slowly in circles. The concentrate will drip onto the ice.",
                     durationSeconds: 30,
                     pourAmountMl: 80),
            BrewStep(name: "Second Pour",
                     description: "Pour the remaining 9ml to flush the last of the grounds.",
                     durationSeconds: 20,
                     pourAmountMl: 9),
            BrewStep(name: "Stir & Serve",
                     description: "Stir the brewed coffee and ice together. Top with fresh ice if desired and serve immediately.",
                     durationSeconds: 0)
        ],
        defaultCoffeeGrams: 18,
        defaultWaterMl: 125,
        difficulty: .intermediate,
        waterTemperatureCelsius: 93
    )

    // MARK: – AeroPress Classic (17g / 220ml)
    static let aeropressClassic = Recipe(
        id: UUID(uuidString: "00000001-0000-0000-0000-000000000003")!,
        name: "AeroPress Classic",
        method: .aeropress,
        steps: [
            BrewStep(name: "Setup",
                     description: "Insert a paper filter into the cap. Rinse with hot water, then attach cap to chamber. Place chamber on a sturdy mug.",
                     durationSeconds: 0),
            BrewStep(name: "Add Coffee",
                     description: "Add 17g of medium-fine ground coffee to the chamber.",
                     durationSeconds: 0),
            BrewStep(name: "Bloom",
                     description: "Start timer. Pour 34ml of water and stir gently to saturate all grounds.",
                     durationSeconds: 30,
                     pourAmountMl: 34),
            BrewStep(name: "Fill",
                     description: "Pour 186ml of water slowly, filling the chamber to the top.",
                     durationSeconds: 20,
                     pourAmountMl: 186),
            BrewStep(name: "Steep",
                     description: "Place the plunger on top but do not press. Let it steep.",
                     durationSeconds: 60),
            BrewStep(name: "Press",
                     description: "Apply steady, gentle pressure. Press all the way down over 25 seconds. Stop when you hear a hiss.",
                     durationSeconds: 25)
        ],
        defaultCoffeeGrams: 17,
        defaultWaterMl: 220,
        difficulty: .easy,
        waterTemperatureCelsius: 90
    )

    // MARK: – Hoffmann V60 (15g / 250ml)
    static let hoffmannV60 = Recipe(
        id: UUID(uuidString: "00000001-0000-0000-0000-000000000005")!,
        name: "Hoffmann V60",
        method: .v60,
        steps: [
            BrewStep(name: "Rinse Filter",
                     description: "Place filter in V60, rinse thoroughly with hot water to seal and preheat. Discard rinse water.",
                     durationSeconds: 0),
            BrewStep(name: "Add Coffee",
                     description: "Add 15g of medium-fine ground coffee. Shake gently to level the bed. Make a small well in the centre.",
                     durationSeconds: 0),
            BrewStep(name: "Bloom",
                     description: "Start timer. Pour 30ml of water (exactly 2× coffee weight) in a steady spiral. All grounds should be wet. Give the dripper a gentle swirl to settle the slurry flat — this is key to even extraction.",
                     durationSeconds: 45,
                     pourAmountMl: 30),
            BrewStep(name: "First Pour",
                     description: "Slowly pour in circles, bringing the total to 150ml. Take your time — aim to reach 150ml by 1:15. A steady, gentle stream is better than a fast one.",
                     durationSeconds: 45,
                     pourAmountMl: 120),
            BrewStep(name: "Second Pour",
                     description: "Continue pouring slowly to reach 250ml total. Aim to finish adding all water by 1:45.",
                     durationSeconds: 30,
                     pourAmountMl: 100),
            BrewStep(name: "Swirl",
                     description: "Give the dripper a gentle swirl to level the coffee bed. This prevents channelling and promotes an even, flat drawdown.",
                     durationSeconds: 0),
            BrewStep(name: "Draw Down",
                     description: "Wait for the coffee to fully drain. Target total brew time is 3:30–3:45. A flat, clean coffee bed at the end is a good sign.",
                     durationSeconds: 0)
        ],
        defaultCoffeeGrams: 15,
        defaultWaterMl: 250,
        difficulty: .intermediate,
        waterTemperatureCelsius: 93
    )

    // MARK: – Hoffmann AeroPress (11g / 200ml)
    static let hoffmannAeroPress = Recipe(
        id: UUID(uuidString: "00000001-0000-0000-0000-000000000006")!,
        name: "Hoffmann AeroPress",
        method: .aeropress,
        steps: [
            BrewStep(name: "Setup Inverted",
                     description: "Push the plunger into the chamber so the rubber sits just above the #4 mark. Stand the AeroPress upside down on the plunger handle. Rinse a paper filter in the cap with hot water, set aside.",
                     durationSeconds: 0),
            BrewStep(name: "Add Coffee",
                     description: "Add 11g of medium-fine ground coffee into the inverted chamber.",
                     durationSeconds: 0),
            BrewStep(name: "Add Water & Stir",
                     description: "Start timer. Pour all 200ml of boiling water (100°C) quickly over the grounds. Stir vigorously for the full 60 seconds — thorough stirring is the secret to even, full extraction.",
                     durationSeconds: 60,
                     pourAmountMl: 200),
            BrewStep(name: "Attach Cap",
                     description: "Screw the filter cap (with rinsed paper filter) firmly onto the chamber. Do not press yet.",
                     durationSeconds: 0),
            BrewStep(name: "Flip",
                     description: "At 2:00, carefully flip the AeroPress onto your mug. Hold the cap firmly against the mug as you flip to avoid spills.",
                     durationSeconds: 0),
            BrewStep(name: "Press",
                     description: "Apply slow, steady downward pressure. Take the full 30 seconds to press. Stop immediately when you hear a hissing sound — that's air, not coffee.",
                     durationSeconds: 30)
        ],
        defaultCoffeeGrams: 11,
        defaultWaterMl: 200,
        difficulty: .intermediate,
        waterTemperatureCelsius: 100
    )

    // MARK: – Hoffmann Iced V60 (20g / 150ml hot + 150g ice)
    static let hoffmannIcedV60 = Recipe(
        id: UUID(uuidString: "00000001-0000-0000-0000-000000000007")!,
        name: "Hoffmann Iced V60",
        method: .v60,
        steps: [
            BrewStep(name: "Prepare Ice",
                     description: "Add 150g of ice to a carafe or serving vessel. Place the V60 directly on top. The hot concentrate will drip straight onto the ice.",
                     durationSeconds: 0),
            BrewStep(name: "Rinse Filter",
                     description: "Insert a paper filter into the V60 and rinse with hot water to seal it. Discard the rinse water.",
                     durationSeconds: 0),
            BrewStep(name: "Add Coffee",
                     description: "Add 20g of medium-coarse ground coffee. Grind slightly coarser than your usual V60 — the concentrated brew compensates for the coarser grind. Shake to level the bed.",
                     durationSeconds: 0),
            BrewStep(name: "Bloom",
                     description: "Start timer. Pour 40ml of water (2× coffee weight) in a slow spiral. Ensure all grounds are saturated. Gently swirl the dripper to settle the slurry.",
                     durationSeconds: 45,
                     pourAmountMl: 40),
            BrewStep(name: "First Pour",
                     description: "Slowly pour in a steady spiral, bringing the total to 95ml. Aim to reach 95ml by 1:15.",
                     durationSeconds: 40,
                     pourAmountMl: 55),
            BrewStep(name: "Second Pour",
                     description: "Continue pouring to reach 150ml total. Finish by 1:50. The drip rate will be slower than a standard V60 — this is normal.",
                     durationSeconds: 35,
                     pourAmountMl: 55),
            BrewStep(name: "Stir & Serve",
                     description: "Once all the coffee has dripped through, stir the brew and melted ice together. The ice dilutes the concentrate to the perfect strength. Serve immediately — add more ice if desired.",
                     durationSeconds: 0)
        ],
        defaultCoffeeGrams: 20,
        defaultWaterMl: 150,
        difficulty: .intermediate,
        waterTemperatureCelsius: 93
    )

    // MARK: – AeroPress Inverted (15g / 230ml)
    static let aeropressInverted = Recipe(
        id: UUID(uuidString: "00000001-0000-0000-0000-000000000004")!,
        name: "AeroPress Inverted",
        method: .aeropress,
        steps: [
            BrewStep(name: "Setup (Inverted)",
                     description: "Attach plunger to chamber, flip upside down so the plunger faces down. Stand the chamber on the plunger handle.",
                     durationSeconds: 0),
            BrewStep(name: "Add Coffee",
                     description: "Add 15g of medium ground coffee to the inverted chamber.",
                     durationSeconds: 0),
            BrewStep(name: "Bloom",
                     description: "Start timer. Pour 30ml of water and stir to saturate grounds evenly.",
                     durationSeconds: 30,
                     pourAmountMl: 30),
            BrewStep(name: "Fill & Stir",
                     description: "Pour 200ml of water into the chamber. Give 3–4 gentle stirs.",
                     durationSeconds: 30,
                     pourAmountMl: 200),
            BrewStep(name: "Steep",
                     description: "Place the filter cap (with rinsed paper filter) loosely on top. Let it steep.",
                     durationSeconds: 90),
            BrewStep(name: "Flip",
                     description: "Carefully flip the AeroPress onto your mug. Hold the cap firmly to prevent spills.",
                     durationSeconds: 0),
            BrewStep(name: "Press",
                     description: "Apply steady, controlled pressure over 25 seconds. Stop pressing when you hear a hiss.",
                     durationSeconds: 25)
        ],
        defaultCoffeeGrams: 15,
        defaultWaterMl: 230,
        difficulty: .advanced,
        waterTemperatureCelsius: 90
    )

    // MARK: – Hoffmann French Press (15g / 250ml)
    static let hoffmannFrenchPress = Recipe(
        id: UUID(uuidString: "00000001-0000-0000-0000-000000000008")!,
        name: "Hoffmann French Press",
        method: .frenchPress,
        steps: [
            BrewStep(name: "Preheat",
                     description: "Fill the French Press with hot water. Place the lid on top and let it sit for 30 seconds to warm the glass. Discard the water and warm the lid separately.",
                     durationSeconds: 0),
            BrewStep(name: "Add Coffee",
                     description: "Add 15g of coarse ground coffee — aim for a grind like raw sugar. Give the French Press a gentle shake to level the bed.",
                     durationSeconds: 0),
            BrewStep(name: "Add All Water",
                     description: "Start timer. Pour all 250ml of water quickly and evenly over the grounds. Place the lid on top with the plunger pulled all the way up — do not press down yet.",
                     durationSeconds: 30,
                     pourAmountMl: 250),
            BrewStep(name: "Steep",
                     description: "Do not stir or disturb the brew. Let the crust form naturally on the surface — this is part of Hoffmann's method for a cleaner cup.",
                     durationSeconds: 240),
            BrewStep(name: "Break Crust & Skim",
                     description: "Use a spoon to gently break the surface crust with 2–3 gentle stirs. Remove the foam and any floating grounds from the surface using the spoon.",
                     durationSeconds: 0),
            BrewStep(name: "Wait & Settle",
                     description: "Remove the lid entirely and allow the grounds to sink to the bottom. Do not press the plunger — this is key to Hoffmann's cleaner French Press method.",
                     durationSeconds: 300),
            BrewStep(name: "Pour & Serve",
                     description: "Pour slowly and gently into your cup. Stop pouring before you reach the thick slurry at the bottom of the press. Enjoy immediately.",
                     durationSeconds: 0)
        ],
        defaultCoffeeGrams: 15,
        defaultWaterMl: 250,
        difficulty: .intermediate,
        waterTemperatureCelsius: 93
    )
}
