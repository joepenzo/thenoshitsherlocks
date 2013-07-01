package components
{
	import citrus.objects.platformer.box2d.Missile;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	public class ExtendedMissile extends Missile
	{
		public function ExtendedMissile(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		override public function handleBeginContact(contact:b2Contact):void {
			//_contact = Box2DUtils.CollisionGetOther(this, contact);
			//if (!contact.GetFixtureA().IsSensor() && !contact.GetFixtureB().IsSensor())
				explode();
				kill = true;
		}

	}
}