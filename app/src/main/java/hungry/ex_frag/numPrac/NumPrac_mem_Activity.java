package hungry.ex_frag.numPrac;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import hungry.ex_frag.ActivityHelper;
import hungry.ex_frag.R;

/**
 * Created by soy on 2016-08-31.
 */
public class NumPrac_mem_Activity extends ActivityHelper {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_numprac_mem);
    }

    public void dateButtonOnclicked(View view) {
        Intent intent = new Intent(this, NumPrac_mem_date_Activity.class);
        startActivity(intent);
    }

    public void scoreButtonOnclicked(View view) {
        Intent intent = new Intent(this, NumPrac_mem_score_Activity.class);
        startActivity(intent);
    }
}