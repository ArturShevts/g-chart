import 'package:myapp/model/exercises.dart';
import 'package:myapp/model/list_instance.dart';
import 'package:myapp/model/list_item.dart';

final String listInstanceFillWithDummyDataQuery = '''
INSERT INTO  $tableListInstances (
  ${ListInstanceFields.userId},
  ${ListInstanceFields.title},
  ${ListInstanceFields.description},
  ${ListInstanceFields.createdTime},
  ${ListInstanceFields.assignedTime},
  ${ListInstanceFields.startedTime},
  ${ListInstanceFields.finishedTime},
  ${ListInstanceFields.isCompleted},
  ${ListInstanceFields.isPublic},
  ${ListInstanceFields.isTemplate},
  ${ListInstanceFields.repeatOn},
  ${ListInstanceFields.repeatEvery}
) VALUES (
  1,
  'Back',
  'Test List Description',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  false,
  false,
  0,
  '6',
  null
), (
  2,
  'Chest',
  'Test List Description',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  false,
  false,
  0,
  '6',
  null
),
 (
  3,
  'Arms',
  'Test List Description',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  false,
  false,
  0,
  '36',
  null
),
 (
  4,
  'Legs',
  'Test List Description',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  false,
  false,
  0,
  '13',
  null
)
''';

const String listItemFillWithDummyDataQuery = '''
INSERT INTO  $tableListItems (
  ${ListItemFields.listInstanceId},
  ${ListItemFields.listItemId},
  ${ListItemFields.userId},
  ${ListItemFields.exerciseId},
  ${ListItemFields.sets},
  ${ListItemFields.quantity},
  ${ListItemFields.weight},
  ${ListItemFields.isCompleted},
  ${ListItemFields.orderNum}

) VALUES (
  1,
  1,
  1,
  11,
  3,
  10,
  15,
  false,
  1
), (
  1,
  2,
  1,
  32,
  3,
  20,
  10,
  false,
  2
), (
  1,
  3,
  1,
  34,
  3,
  12,
  10,
  false,
  3
), (
  2,  
  4,
  2,
  43,
  3,
  10,
  15,
  false,
  4
), (
  2,
  5,
  2,
  12,
  3,
  20,
  10,
  false,
  5
  )
''';

final String exercisesInsertDataQuery = '''
INSERT INTO
 $tableExercises (
  ${ExerciseFields.category},
  ${ExerciseFields.equipment},
  ${ExerciseFields.force},
  ${ExerciseFields.instructions},
  ${ExerciseFields.level},
  ${ExerciseFields.mechanic},
  ${ExerciseFields.name},
  ${ExerciseFields.primaryMuscles},
  ${ExerciseFields.secondaryMuscles}
) VALUES (
   'strength', 'body only', 'pull',  '{"Lie down on the floor and secure your feet. Your legs should be bent at the knees.","Place your hands behind or to the side of your head. You will begin with your back on the ground. This will be your starting position.","Flex your hips and spine to raise your torso toward your knees.","At the top of the contraction your torso should be perpendicular to the ground. Reverse the motion, going only Â¾ of the way down.","Repeat for the recommended amount of repetitions."}', 'beginner', 'compound', '3/4 Sit-Up', '{"abdominals"}', '{}'), ('stretching', 'body only', 'push',  '{"Lie on your back, with one leg extended straight out.","With the other leg, bend the hip and knee to 90 degrees. You may brace your leg with your hands if necessary. This will be your starting position.","Extend your leg straight into the air, pausing briefly at the top. Return the leg to the starting position.","Repeat for 10-20 repetitions, and then switch to the other leg."}', 'beginner', NULL, '90/90 Hamstring', '{"hamstrings"}', '{"calves"}'), ('strength', 'machine', 'pull',  '{"Select a light resistance and sit down on the ab machine placing your feet under the pads provided and grabbing the top handles. Your arms should be bent at a 90 degree angle as you rest the triceps on the pads provided. This will be your starting position.","At the same time, begin to lift the legs up as you crunch your upper torso. Breathe out as you perform this movement. Tip: Be sure to use a slow and controlled motion. Concentrate on using your abs to move the weight while relaxing your legs and feet.","After a second pause, slowly return to the starting position as you breathe in.","Repeat the movement for the prescribed amount of repetitions."}', 'intermediate', 'isolation', 'Ab Crunch Machine', '{"abdominals"}', '{}'), ('strength', 'other', 'pull',  '{"Hold the Ab Roller with both hands and kneel on the floor.","Now place the ab roller on the floor in front of you so that you are on all your hands and knees (as in a kneeling push up position). This will be your starting position.","Slowly roll the ab roller straight forward, stretching your body into a straight position. Tip: Go down as far as you can without touching the floor with your body. Breathe in during this portion of the movement.","After a pause at the stretched position, start pulling yourself back to the starting position as you breathe out. Tip: Go slowly and keep your abs tight at all times."}', 'intermediate', 'compound', 'Ab Roller', '{"abdominals"}', '{"shoulders"}'), ('stretching', 'foam roll', 'static',  '{"Lie face down with one leg on a foam roll.","Rotate the leg so that the foam roll contacts against your inner thigh. Shift as much weight onto the foam roll as can be tolerated.","While trying to relax the muscles if the inner thigh, roll over the foam between your hip and knee, holding points of tension for 10-30 seconds. Repeat with the other leg."}', 'intermediate', 'isolation', 'Adductor', '{"adductors"}', '{}'), ('stretching', NULL, 'static',  '{"Lie on your back with your feet raised towards the ceiling.","Have your partner hold your feet or ankles. Abduct your legs as far as you can. This will be your starting position.","Attempt to squeeze your legs together for 10 or more seconds, while your partner prevents you from doing so.","Now, relax the muscles in your legs as your partner pushes your feet apart, stretching as far as is comfortable for you. Be sure to let your partner know when the stretch is adequate to prevent overstretching or injury."}', 'intermediate', NULL, 'Adductor/Groin', '{"adductors"}', '{}'), ('strength', 'kettlebells', 'push',  '{"Clean and press a kettlebell overhead with one arm.","Keeping the kettlebell locked out at all times, push your butt out in the direction of the locked out kettlebell. Keep the non-working arm behind your back and turn your feet out at a forty-five degree angle from the arm with the kettlebell.","Lower yourself as far as possible.","Pause for a second and reverse the motion back to the starting position."}', 'intermediate', 'isolation', 'Advanced Kettlebell Windmill', '{"abdominals"}', '{"glutes","hamstrings","shoulders"}'), ('strength', 'body only', 'pull',  '{"Lie flat on the floor with your lower back pressed to the ground. For this exercise, you will need to put your hands beside your head. Be careful however to not strain with the neck as you perform it. Now lift your shoulders into the crunch position.","Bring knees up to where they are perpendicular to the floor, with your lower legs parallel to the floor. This will be your starting position.","Now simultaneously, slowly go through a cycle pedal motion kicking forward with the right leg and bringing in the knee of the left leg. Bring your right elbow close to your left knee by crunching to the side, as you breathe out.","Go back to the initial position as you breathe in.","Crunch to the opposite side as you cycle your legs and bring closer your left elbow to your right knee and exhale.","Continue alternating in this manner until all of the recommended repetitions for each side have been completed."}', 'beginner', 'compound', 'Air Bike', '{"abdominals"}', '{}'), ('stretching', 'body only', 'static',  '{"Start off on your hands and knees, then lift your leg off the floor and hold the foot with your hand.","Use your hand to hold the foot or ankle, keeping the knee fully flexed, stretching the quadriceps and hip flexors.","Focus on extending your hips, thrusting them towards the floor. Hold for 10-20 seconds and then switch sides."}', 'intermediate', NULL, 'All Fours Quad Stretch', '{"quadriceps"}', '{"quadriceps"}'), ('strength', 'dumbbell', 'pull',  '{"Stand up with your torso upright and a dumbbell in each hand being held at arms length. The elbows should be close to the torso.","The palms of the hands should be facing your torso. This will be your starting position.","While holding the upper arm stationary, curl the right weight forward while contracting the biceps as you breathe out. Continue the movement until your biceps is fully contracted and the dumbbells are at shoulder level. Hold the contracted position for a second as you squeeze the biceps. Tip: Only the forearms should move.","Slowly begin to bring the dumbbells back to starting position as your breathe in.","Repeat the movement with the left hand. This equals one repetition.","Continue alternating in this manner for the recommended amount of repetitions."}', 'beginner', 'isolation', 'Alternate Hammer Curl', '{"biceps"}', '{"forearms"}'), ('strength', 'body only', 'pull',  '{"Lie on the floor with the knees bent and the feet on the floor around 18-24 inches apart. Your arms should be extended by your side. This will be your starting position.","Crunch over your torso forward and up about 3-4 inches to the right side and touch your right heel as you hold the contraction for a second. Exhale while performing this movement.","Now go back slowly to the starting position as you inhale.","Now crunch over your torso forward and up around 3-4 inches to the left side and touch your left heel as you hold the contraction for a second. Exhale while performing this movement and then go back to the starting position as you inhale. Now that both heels have been touched, that is considered 1 repetition.","Continue alternating sides in this manner until all prescribed repetitions are done."}', 'beginner', 'isolation', 'Alternate Heel Touchers', '{"abdominals"}', '{}'), ('strength', 'dumbbell', 'pull',  '{"Sit down on an incline bench with a dumbbell in each hand being held at arms length. Tip: Keep the elbows close to the torso.This will be your starting position.","While holding the upper arm stationary, curl the right weight forward while contracting the biceps as you breathe out. As you do so, rotate the hand so that the palm is facing up. Continue the movement until your biceps is fully contracted and the dumbbells are at shoulder level. Hold the contracted position for a second as you squeeze the biceps. Tip: Only the forearms should move.","Slowly begin to bring the dumbbell back to starting position as your breathe in.","Repeat the movement with the left hand. This equals one repetition.","Continue alternating in this manner for the recommended amount of repetitions."}', 'beginner', 'isolation', 'Alternate Incline Dumbbell Curl', '{"biceps"}', '{"forearms"}'), ('plyometrics', NULL, 'push',  '{"Assume a comfortable stance with one foot slightly in front of the other.","Begin by pushing off with the front leg, driving the opposite knee forward and as high as possible before landing. Attempt to cover as much distance to each side with each bound.","It may help to use a line on the ground to guage distance from side to side.","Repeat the sequence with the other leg."}', 'beginner', 'compound', 'Alternate Leg Diagonal Bound', '{"quadriceps"}', '{"abductors","adductors","calves","glutes","hamstrings"}'), ('strength', 'cable', 'push',  '{"Move the cables to the bottom of the tower and select an appropriate weight.","Grasp the cables and hold them at shoulder height, palms facing forward. This will be your starting position.","Keeping your head and chest up, extend through the elbow to press one side directly over head.","After pausing at the top, return to the starting position and repeat on the opposite side."}', 'beginner', 'compound', 'Alternating Cable Shoulder Press', '{"shoulders"}', '{"triceps"}'), ('strength', 'dumbbell', 'push',  '{"In a standing position, hold a pair of dumbbells at your side.","Keeping your elbows slightly bent, raise the weights directly in front of you to shoulder height, avoiding any swinging or cheating.","Return the weights to your side.","On the next repetition, raise the weights laterally, raising them out to your side to about shoulder height.","Return the weights to the starting position and continue alternating to the front and side."}', 'beginner', 'isolation', 'Alternating Deltoid Raise', '{"shoulders"}', '{}'), ('strength', 'kettlebells', 'push',  '{"Lie on the floor with two kettlebells next to your shoulders.","Position one in place on your chest and then the other, gripping the kettlebells on the handle with the palms facing forward.","Extend both arms, so that the kettlebells are being held above your chest. Lower one kettlebell, bringing it to your chest and turn the wrist in the direction of the locked out kettlebell.","Raise the kettlebell and repeat on the opposite side."}', 'beginner', 'compound', 'Alternating Floor Press', '{"chest"}', '{"abdominals","shoulders","triceps"}'), ('strength', 'kettlebells', 'pull',  '{"Place two kettlebells between your feet. To get in the starting position, push your butt back and look straight ahead.","Clean one kettlebell to your shoulder and hold on to the other kettlebell in a hanging position. Clean the kettlebell to your shoulder by extending through the legs and hips as you pull the kettlebell towards your shoulders. Rotate your wrist as you do so.","Lower the cleaned kettlebell to a hanging position and clean the alternate kettlebell. Repeat."}', 'intermediate', 'compound', 'Alternating Hang Clean', '{"hamstrings"}', '{"biceps","calves","forearms","glutes","lower back","traps"}'), ('strength', 'kettlebells', 'push',  '{"Clean two kettlebells to your shoulders. Clean the kettlebells to your shoulders by extending through the legs and hips as you pull the kettlebells towards your shoulders. Rotate your wrists as you do so.","Press one directly overhead by extending through the elbow, turning it so the palm faces forward while holding the other kettlebell stationary .","Lower the pressed kettlebell to the starting position and immediately press with your other arm."}', 'intermediate', 'compound', 'Alternating Kettlebell Press', '{"shoulders"}', '{"triceps"}'), ('strength', 'kettlebells', 'pull',  '{"Place two kettlebells in front of your feet. Bend your knees slightly and push your butt out as much as possible. As you bend over to get into the starting position grab both kettlebells by the handles.","Pull one kettlebell off of the floor while holding on to the other kettlebell. Retract the shoulder blade of the working side, as you flex the elbow, drawing the kettlebell towards your stomach or rib cage.","Lower the kettlebell in the working arm and repeat with your other arm."}', 'intermediate', 'isolation', 'Alternating Kettlebell Row', '{"middle back"}', '{"biceps","lats"}'), ('strength', 'kettlebells', 'pull',  '{"Place two kettlebells on the floor about shoulder width apart. Position yourself on your toes and your hands as though you were doing a pushup, with the body straight and extended. Use the handles of the kettlebells to support your upper body. You may need to position your feet wide for support.","Push one kettlebell into the floor and row the other kettlebell, retracting the shoulder blade of the working side as you flex the elbow, pulling it to your side.","Then lower the kettlebell to the floor and begin the kettlebell in the opposite hand. Repeat for several reps."}', 'expert', 'compound', 'Alternating Renegade Row', '{"middle back"}', '{"abdominals","biceps","chest","lats","triceps"}'), ('stretching', NULL, 'pull',  '{"Use a sturdy object like a squat rack to hold yourself.","Lift the right leg in the air (just around 2 inches from the floor) and perform a circular motion with the big toe. Pretend that you are drawing a big circle with it. Tip: One circle equals 1 repetition. Breathe normally as you perform the movement.","When you are done with the right foot, then repeat with the left leg."}', 'beginner', 'isolation', 'Ankle Circles', '{"calves"}', '{}'), ('stretching', NULL, 'static',  '{"From a lying position, bend your knees and keep your feet on the floor.","Place your ankle of one foot on your opposite knee.","Grasp the thigh or knee of the bottom leg and pull both of your legs into the chest. Relax your neck and shoulders. Hold for 10-20 seconds and then switch sides."}', 'beginner', NULL, 'Ankle On The Knee', '{"glutes"}', '{}'), ('stretching', 'other', 'static',  '{"Begin seated on the ground with your legs bent and your feet on the floor.","Using a Muscle Roller or a rolling pin, apply pressure to the muscles on the outside of your shins. Work from just below the knee to above the ankle, pausing at points of tension for 10-30 seconds. Repeat on the other leg."}', 'intermediate', NULL, 'Anterior Tibialis-SMR', '{"calves"}', '{}'), ('strength', 'barbell', 'push',  '{"Place a bar on the ground behind the head of an incline bench.","Lay on the bench face down. With a pronated grip, pick the barbell up from the floor. Flex the elbows, performing a reverse curl to bring the bar near your chest. This will be your starting position.","To begin, press the barbell out in front of your head by extending your elbows. Keep your arms parallel to the ground throughout the movement.","Return to the starting position and repeat to complete the set."}', 'beginner', 'compound', 'Anti-Gravity Press', '{"shoulders"}', '{"middle back","traps","triceps"}'), ('stretching', NULL, 'push',  '{"Stand up and extend your arms straight out by the sides. The arms should be parallel to the floor and perpendicular (90-degree angle) to your torso. This will be your starting position.","Slowly start to make circles of about 1 foot in diameter with each outstretched arm. Breathe normally as you perform the movement.","Continue the circular motion of the outstretched arms for about ten seconds. Then reverse the movement, going the opposite direction."}', 'beginner', 'isolation', 'Arm Circles', '{"shoulders"}', '{"traps"}'), ('strength', 'dumbbell', 'push',  '{"Sit on an exercise bench with back support and hold two dumbbells in front of you at about upper chest level with your palms facing your body and your elbows bent. Tip: Your arms should be next to your torso. The starting position should look like the contracted portion of a dumbbell curl.","Now to perform the movement, raise the dumbbells as you rotate the palms of your hands until they are facing forward.","Continue lifting the dumbbells until your arms are extended above you in straight arm position. Breathe out as you perform this portion of the movement.","After a second pause at the top, begin to lower the dumbbells to the original position by rotating the palms of your hands towards you. Tip: The left arm will be rotated in a counter clockwise manner while the right one will be rotated clockwise. Breathe in as you perform this portion of the movement.","Repeat for the recommended amount of repetitions."}', 'intermediate', 'compound', 'Arnold Dumbbell Press', '{"shoulders"}', '{"triceps"}'), ('strength', 'dumbbell', 'push',  '{"Lay down on a flat bench holding a dumbbell in each hand with the palms of the hands facing towards the ceiling. Tip: Your arms should be parallel to the floor and next to your thighs. To avoid injury, make sure that you keep your elbows slightly bent. This will be your starting position.","Now move the dumbbells by creating a semi-circle as you displace them from the initial position to over the head. All of the movement should happen with the arms parallel to the floor at all times. Breathe in as you perform this portion of the movement.","Reverse the movement to return the weight to the starting position as you exhale."}', 'intermediate', 'compound', 'Around The Worlds', '{"chest"}', '{"shoulders"}'), ('strongman', 'other', 'pull',  '{"Begin with the atlas stone between your feet. Bend at the hips to wrap your arms vertically around the Atlas Stone, attempting to get your fingers underneath the stone. Many stones will have a small flat portion on the bottom, which will make the stone easier to hold.","Pulling the stone into your torso, drive through the back half of your feet to pull the stone from the ground.","As the stone passes the knees, lap it by sitting backward, pulling the stone on top of your thighs.","Sit low, getting the stone high onto your chest as you change your grip to reach over the stone. Stand, driving through with your hips. Close distance to the loading platform, and lean back, extending the hips to get the stone as high as possible."}', 'expert', 'compound', 'Atlas Stones', '{"lower back"}', '{"abdominals","adductors","biceps","calves","forearms","glutes","hamstrings","middle back","quadriceps","traps"}'), ('strongman', 'other', 'pull',  '{"This trainer is effective for developing Atlas Stone strength for those who don''t have access to stones, and are typically made from bar ends or heavy pipe.","Begin by loading the desired weight onto the bar. Straddle the weight, wrapping your arms around the implement, bending at the hips.","Begin by pulling the weight up past the knees, extending through the hips. As the weight clears the knees, it can be lapped by resting it on your thighs and sitting back, hugging it tightly to your chest.","Finish the movement by extending through your hips and knees to raise the weight as high as possible. The weight can be returned to the lap or to the ground for successive repetitions."}', 'intermediate', 'compound', 'Atlas Stone Trainer', '{"lower back"}', '{"biceps","forearms","glutes","hamstrings","quadriceps"}')
   ''';
