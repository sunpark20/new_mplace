package hungry.ex_frag;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class NoticeActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_notice);

        String title = getIntent().getStringExtra("title");
        String noticeText = getIntent().getStringExtra("notice_text");
        int imageResId = getIntent().getIntExtra("image", 0);

        TextView diaTitle = findViewById(R.id.dialogTitle);
        if (title != null) diaTitle.setText(title);

        TextView tv = findViewById(R.id.tv);
        if (noticeText != null) tv.setText(noticeText);

        if (imageResId != 0) {
            ImageView iv = findViewById(R.id.iv);
            iv.setVisibility(View.VISIBLE);
            iv.setImageResource(imageResId);
        }

        View exitBtn = findViewById(R.id.exit);
        if (exitBtn != null) exitBtn.setOnClickListener(v -> finish());

        View exit2Btn = findViewById(R.id.exit2);
        if (exit2Btn != null) exit2Btn.setOnClickListener(v -> finish());
    }
}
