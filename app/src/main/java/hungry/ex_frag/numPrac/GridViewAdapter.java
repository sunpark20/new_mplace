package hungry.ex_frag.numPrac;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.HashSet;

import hungry.ex_frag.R;

public class GridViewAdapter extends BaseAdapter {
    private final Context context;
    private final ArrayList<String> numberList;
    private final HashSet<Integer> scoreSet;

    public GridViewAdapter(Context context, ArrayList<String> numberList, HashSet<Integer> scoreSet) {
        this.context = context;
        this.numberList = numberList;
        this.scoreSet = scoreSet;
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            convertView = LayoutInflater.from(context).inflate(R.layout.item_numprac_mem_score, parent, false);
        }

        TextView tv = (TextView) convertView.findViewById(R.id.num);
        String numberString = numberList.get(position);
        tv.setText(numberString);

        try {
            int number = Integer.parseInt(numberString);
            if (scoreSet != null && scoreSet.contains(number)) {
                tv.setTextColor(context.getResources().getColor(R.color.green));
                tv.setBackgroundColor(context.getResources().getColor(R.color.black));
            } else {
                setDefault(tv);
            }
        } catch (NumberFormatException e) {
            setDefault(tv);
        }

        return convertView;
    }

    private void setDefault(TextView tv) {
        tv.setTextColor(context.getResources().getColor(R.color.black));
        tv.setBackgroundColor(context.getResources().getColor(R.color.white));
    }

    @Override
    public int getCount() {
        return numberList.size();
    }

    @Override
    public Object getItem(int position) {
        return numberList.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }
}
