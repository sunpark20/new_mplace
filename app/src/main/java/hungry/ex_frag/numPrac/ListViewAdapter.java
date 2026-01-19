package hungry.ex_frag.numPrac;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import hungry.ex_frag.R;


class ListViewAdapter extends BaseAdapter {
    private Context context;
    SavedDate sd;

    public ListViewAdapter(Context context, SavedDate sd) {
        this.context = context;
        this.sd = sd;
    }

    public View getView(int position, View convertView, ViewGroup parent) {

        LayoutInflater inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View listView;
        TextView tv=null;

        //틀만 재사용한다.
        if (convertView == null) {
            listView = new View(context);
            // get layout from mobile.xml
            listView = inflater.inflate(R.layout.item_numprac_mem_date, null);
        } else {
            listView = (View) convertView;
        }
        // set value into textview
        tv = (TextView) listView
                .findViewById(R.id.num);
        int reversePosition=sd.date.size()-1-position;
        String temp=sd.date.get(reversePosition)+"\n소요시간 - "+sd.time.get(reversePosition)+"\n틀린개수 - "+sd.inco.get(reversePosition);
        tv.setText(temp);


        return listView;
    }

    @Override
    public int getCount() {
        return sd.date.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

}
