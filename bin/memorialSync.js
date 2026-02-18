#!/usr/bin/osascript -l JavaScript

(function () {
  'use strict';

  ObjC.import('Foundation');

  const Calendar = Application('Calendar');
  const Contacts = Application('Contacts');

  // Ensure "Memorials" calendar exists
  let memorialCal;
  try {
    memorialCal = Calendar.calendars.byName('Memorials');
  } catch (e) {
    memorialCal = Calendar.Calendar({ name: 'Memorials' });
    Calendar.calendars.push(memorialCal);
    console.log('✅ Created "Memorials" calendar');
  }

  const allContacts = Contacts.people();

  allContacts.forEach((contact) => {
    const name = contact.name();
    console.log(`👱🏻‍♂️ Processing ${name}...`);

    try {
      const vcard = contact.vcard();
      const lines = vcard.split('\n');
      let previousLine = '';
      lines.forEach((line) => {
        if (
          line.includes('X-ABLabel:deceased') &&
          previousLine.includes('X-ABDATE')
        ) {
          const dateString = previousLine.split(':')[1];
          const dateParts = dateString.split('-').map(Number);
          // Create JS Date (months are 0-based)
          const deceasedDate = new Date(
            dateParts[0],
            dateParts[1] - 1,
            dateParts[2]
          );
          const endDeceasedDate = new Date(
            dateParts[0],
            dateParts[1] - 1,
            dateParts[2],
            23,
            59,
            59
          );
          if (!deceasedDate || isNaN(deceasedDate)) {
            console.log(`⚠️ Invalid date for ${name}: ${dateString}`);
            return;
          }

          // Calculate years since death
          const now = new Date();
          const yearsSince = now.getFullYear() - deceasedDate.getFullYear();
          const ordinalSuffix = getOrdinalSuffix(yearsSince);
          const eventTitle = `${name}'s Memorial (${deceasedDate.getFullYear()})`;

          console.log(
            `Processing: ${name} → Event: "${eventTitle}" on ${deceasedDate} `
          );

          // Check if event already exists
          const existingEvents = memorialCal.events.whose({
            summary: eventTitle,
          })();
          if (existingEvents.length === 0) {
            // Create a true all-day yearly event
            const event = Calendar.Event({
              summary: eventTitle,
              alldayEvent: true,
              startDate: deceasedDate,
              endDate: endDeceasedDate,
              recurrence: 'FREQ=YEARLY',
            });

            memorialCal.events.push(event);

            console.log(`✅ Created event: ${eventTitle}`);
          } else {
            console.log(`↩️ Event already exists: ${eventTitle}`);
          }
        }
        previousLine = line;
      });
    } catch (err) {
      console.log(`⚠️ Error processing ${name}: ${err}`);
    }
  });

  console.log('Memorial sync complete.');

  // Helper: English ordinal suffix
  function getOrdinalSuffix(n) {
    const mod100 = n % 100;
    if ([11, 12, 13].includes(mod100)) return 'th';
    const mod10 = n % 10;
    if (mod10 === 1) return 'st';
    if (mod10 === 2) return 'nd';
    if (mod10 === 3) return 'rd';
    return 'th';
  }
})();
