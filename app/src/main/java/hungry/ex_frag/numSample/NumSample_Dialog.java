package hungry.ex_frag.numSample;

import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import hungry.ex_frag.R;

public class NumSample_Dialog extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.dialog_numsample);

        TextView name = findViewById(R.id.namet);
        TextView cha = findViewById(R.id.charact);
        TextView des = findViewById(R.id.desct);

        Item item = (Item) getIntent().getSerializableExtra("item");

        if (item != null) {
            name.setText(item.getName());
            cha.setText(item.getCha());
            des.setText(item.getDes());
        }
    }
}
