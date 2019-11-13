// All links-related publications

import { Meteor } from 'meteor/meteor';
import { Links } from '../links.ts';

Meteor.publish('links.all', function () {
  return Links.find();
});
