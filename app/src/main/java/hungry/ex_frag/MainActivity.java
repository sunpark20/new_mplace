package hungry.ex_frag;

import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import androidx.core.app.ActivityCompat;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;

import hungry.ex_frag.day.Day_Activity;
import hungry.ex_frag.day.day0;
import hungry.ex_frag.day.day1;
import hungry.ex_frag.day.day2;
import hungry.ex_frag.day.day3;
import hungry.ex_frag.day.day3_2;
import hungry.ex_frag.day.day4;
import hungry.ex_frag.day.day5_fc;
import hungry.ex_frag.day.day6_pao;
import hungry.ex_frag.numPrac.NumPrac_Activity;
import hungry.ex_frag.numSample.NumSample_Activity;

public class MainActivity extends ActivityHelper {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        AdView mAdView = findViewById(R.id.adView111);
        mAdView.loadAd(new AdRequest.Builder().build());
    }

    public void day0ButtonOnClicked(View view) {
        Intent intent = new Intent(this, Day_Activity.class);
        intent.putExtra("title", getString(R.string.intro));
        intent.putExtra("tiArray", day0.getTiArray());
        startActivity(intent);
    }

    public void day1ButtonOnClicked(View view) {
        Intent intent = new Intent(this, Day_Activity.class);
        intent.putExtra("title", getString(R.string.day1));
        intent.putExtra("tiArray", day1.getTiArray());
        startActivity(intent);
    }

    public void day2ButtonOnClicked(View view) {
        Intent intent = new Intent(this, Day_Activity.class);
        intent.putExtra("title", getString(R.string.day2));
        intent.putExtra("tiArray", day2.getTiArray());
        startActivity(intent);
    }

    public void day3ButtonOnClicked(View view) {
        Intent intent = new Intent(this, Day_Activity.class);
        intent.putExtra("title", getString(R.string.day3));
        intent.putExtra("tiArray", day3.getTiArray());
        startActivity(intent);
    }

    public void day3_2ButtonOnClicked(View view) {
        Intent intent = new Intent(this, Day_Activity.class);
        intent.putExtra("title", getString(R.string.day3_2));
        intent.putExtra("tiArray", day3_2.getTiArray());
        startActivity(intent);
    }

    public void day4ButtonOnClicked(View view) {
        Intent intent = new Intent(this, Day_Activity.class);
        intent.putExtra("title", getString(R.string.day4));
        intent.putExtra("tiArray", day4.getTiArray());
        startActivity(intent);
    }

    public void peopleToNumsampleButtonOnClicked(View view) {
        startActivity(new Intent(this, NumSample_Activity.class));
    }

    public void firstChallengeButtonOnClicked(View view) {
        Intent intent = new Intent(this, Day_Activity.class);
        intent.putExtra("title", getString(R.string.day_fc));
        intent.putExtra("tiArray", day5_fc.getTiArray());
        startActivity(intent);
    }

    public void day_paoButtonOnClicked(View view) {
        Intent intent = new Intent(this, Day_Activity.class);
        intent.putExtra("title", getString(R.string.day_pao));
        intent.putExtra("tiArray", day6_pao.getTiArray());
        startActivity(intent);
    }

    public void day6_pacButtonOnClicked(View view) {
        startActivity(new Intent(this, NumPrac_Activity.class));
    }

    public void tedVideoButtonOnClicked(View view) {
        try {
            java.io.File file = new java.io.File(getCacheDir(), "ted_video.mp4");
            if (!file.exists()) {
                java.io.InputStream in = getResources().openRawResource(R.raw.ted_video);
                java.io.OutputStream out = new java.io.FileOutputStream(file);
                byte[] buffer = new byte[1024];
                int read;
                while ((read = in.read(buffer)) != -1) {
                    out.write(buffer, 0, read);
                }
                in.close();
                out.flush();
                out.close();
            }

            Uri videoUri = androidx.core.content.FileProvider.getUriForFile(this, getPackageName() + ".fileprovider", file);
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setDataAndType(videoUri, "video/*");
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            startActivity(Intent.createChooser(intent, "동영상 재생"));
        } catch (Exception e) {
            e.printStackTrace();
            Toast.makeText(this, "동영상을 재생할 수 없습니다: " + e.getMessage(), Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    public void onBackPressed() {
        ActivityCompat.finishAffinity(this);
        System.exit(0);
    }
}
