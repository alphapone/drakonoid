package tk.tcl.hello;

import android.content.*;

public class HelloBoot extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
	Class cls = tk.tcl.hello.HelloTclTk.class;
	intent = new Intent(intent.getAction(), null, context, cls);
	intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
	context.startActivity(intent);
    }

} 
