Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EF421E7F9
	for <lists+linux-block@lfdr.de>; Tue, 14 Jul 2020 08:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgGNGUx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Jul 2020 02:20:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:46292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgGNGUx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jul 2020 02:20:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09D74B635;
        Tue, 14 Jul 2020 06:20:53 +0000 (UTC)
Subject: Re: [PATCH] bcache: add a new sysfs interface to disable refill when
 read miss
To:     Hannes Reinecke <hare@suse.de>, Guoju Fang <fangguoju@gmail.com>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1594610902-4428-1-git-send-email-fangguoju@gmail.com>
 <141fbeaf-8fb6-43fb-56ed-5f8a5a019cc7@suse.de>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 mQINBFYX6S8BEAC9VSamb2aiMTQREFXK4K/W7nGnAinca7MRuFUD4JqWMJ9FakNRd/E0v30F
 qvZ2YWpidPjaIxHwu3u9tmLKqS+2vnP0k7PRHXBYbtZEMpy3kCzseNfdrNqwJ54A430BHf2S
 GMVRVENiScsnh4SnaYjFVvB8SrlhTsgVEXEBBma5Ktgq9YSoy5miatWmZvHLFTQgFMabCz/P
 j5/xzykrF6yHo0rHZtwzQzF8rriOplAFCECp/t05+OeHHxjSqSI0P/G79Ll+AJYLRRm9til/
 K6yz/1hX5xMToIkYrshDJDrUc8DjEpISQQPhG19PzaUf3vFpmnSVYprcWfJWsa2wZyyjRFkf
 J51S82WfclafNC6N7eRXedpRpG6udUAYOA1YdtlyQRZa84EJvMzW96iSL1Gf+ZGtRuM3k49H
 1wiWOjlANiJYSIWyzJjxAd/7Xtiy/s3PRKL9u9y25ftMLFa1IljiDG+mdY7LyAGfvdtIkanr
 iBpX4gWXd7lNQFLDJMfShfu+CTMCdRzCAQ9hIHPmBeZDJxKq721CyBiGAhRxDN+TYiaG/UWT
 7IB7LL4zJrIe/xQ8HhRO+2NvT89o0LxEFKBGg39yjTMIrjbl2ZxY488+56UV4FclubrG+t16
 r2KrandM7P5RjR+cuHhkKseim50Qsw0B+Eu33Hjry7YCihmGswARAQABtBhDb2x5IExpIDxj
 b2x5bGlAc3VzZS5kZT6JAlYEEwEIAEACGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgBYh
 BOo+RS/0+Uhgjej60Mc5B5Nrffj8BQJcR84dBQkY++fuAAoJEMc5B5Nrffj8ixcP/3KAKg1X
 EcoW4u/0z+Ton5rCyb/NpAww8MuRjNW82UBUac7yCi1y3OW7NtLjuBLw5SaVG5AArb7IF3U0
 qTOobqfl5XHsT0o5wFHZaKUrnHb6y7V3SplsJWfkP3JmOooJsQB3z3K96ZTkFelsNb0ZaBRu
 gV+LA4MomhQ+D3BCDR1it1OX/tpvm2uaDF6s/8uFtcDEM9eQeqATN/QAJ49nvU/I8zDSY9rc
 0x9mP0x+gH4RccbnoPu/rUG6Fm1ZpLrbb6NpaYBBJ/V1BC4lIOjnd24bsoQrQmnJn9dSr60X
 1MY60XDszIyzRw7vbJcUn6ZzPNFDxFFT9diIb+wBp+DD8ZlD/hnVpl4f921ZbvfOSsXAJrKB
 1hGY17FPwelp1sPcK2mDT+pfHEMV+OQdZzD2OCKtza/5IYismJJm3oVUYMogb5vDNAw9X2aP
 XgwUuG+FDEFPamFMUwIfzYHcePfqf0mMsaeSgtA/xTxzx/0MLjUJHl46Bc0uKDhv7QUyGz0j
 Ywgr2mHTvG+NWQ/mDeHNGkcnsnp3IY7koDHnN2xMFXzY4bn9m8ctqKo2roqjCzoxD/njoAhf
 KBzdybLHATqJG/yiZSbCxDA1n/J4FzPyZ0rNHUAJ/QndmmVspE9syFpFCKigvvyrzm016+k+
 FJ59Q6RG4MSy/+J565Xj+DNY3/dCuQINBFYX6S8BEADZP+2cl4DRFaSaBms08W8/smc5T2CO
 YhAoygZn71rB7Djml2ZdvrLRjR8Qbn0Q/2L2gGUVc63pJnbrjlXSx2LfAFE0SlfYIJ11aFdF
 9w7RvqWByQjDJor3Z0fWvPExplNgMvxpD0U0QrVT5dIGTx9hadejCl/ug09Lr6MPQn+a4+qs
 aRWwgCSHaIuDkH3zI1MJXiqXXFKUzJ/Fyx6R72rqiMPHH2nfwmMu6wOXAXb7+sXjZz5Po9GJ
 g2OcEc+rpUtKUJGyeQsnCDxUcqJXZDBi/GnhPCcraQuqiQ7EGWuJfjk51vaI/rW4bZkA9yEP
 B9rBYngbz7cQymUsfxuTT8OSlhxjP3l4ZIZFKIhDaQeZMj8pumBfEVUyiF6KVSfgfNQ/5PpM
 R4/pmGbRqrAAElhrRPbKQnCkGWDr8zG+AjN1KF6rHaFgAIO7TtZ+F28jq4reLkur0N5tQFww
 wFwxzROdeLHuZjL7eEtcnNnzSkXHczLkV4kQ3+vr/7Gm65mQfnVpg6JpwpVrbDYQeOFlxZ8+
 GERY5Dag4KgKa/4cSZX2x/5+KkQx9wHwackw5gDCvAdZ+Q81nm6tRxEYBBiVDQZYqO73stgT
 ZyrkxykUbQIy8PI+g7XMDCMnPiDncQqgf96KR3cvw4wN8QrgA6xRo8xOc2C3X7jTMQUytCz9
 0MyV1QARAQABiQI8BBgBCAAmAhsMFiEE6j5FL/T5SGCN6PrQxzkHk2t9+PwFAlxHziAFCRj7
 5/EACgkQxzkHk2t9+PxgfA//cH5R1DvpJPwraTAl24SUcG9EWe+NXyqveApe05nk15zEuxxd
 e4zFEjo+xYZilSveLqYHrm/amvQhsQ6JLU+8N60DZHVcXbw1Eb8CEjM5oXdbcJpXh1/1BEwl
 4phsQMkxOTns51bGDhTQkv4lsZKvNByB9NiiMkT43EOx14rjkhHw3rnqoI7ogu8OO7XWfKcL
 CbchjJ8t3c2XK1MUe056yPpNAT2XPNF2EEBPG2Y2F4vLgEbPv1EtpGUS1+JvmK3APxjXUl5z
 6xrxCQDWM5AAtGfM/IswVjbZYSJYyH4BQKrShzMb0rWUjkpXvvjsjt8rEXpZEYJgX9jvCoxt
 oqjCKiVLpwje9WkEe9O9VxljmPvxAhVqJjX62S+TGp93iD+mvpCoHo3+CcvyRcilz+Ko8lfO
 hS9tYT0HDUiDLvpUyH1AR2xW9RGDevGfwGTpF0K6cLouqyZNdhlmNciX48tFUGjakRFsxRmX
 K0Jx4CEZubakJe+894sX6pvNFiI7qUUdB882i5GR3v9ijVPhaMr8oGuJ3kvwBIA8lvRBGVGn
 9xvzkQ8Prpbqh30I4NMp8MjFdkwCN6znBKPHdjNTwE5PRZH0S9J0o67IEIvHfH0eAWAsgpTz
 +jwc7VKH7vkvgscUhq/v1/PEWCAqh9UHy7R/jiUxwzw/288OpgO+i+2l11Y=
Message-ID: <7f52be25-3bcd-17b9-b9a7-219820d71c17@suse.de>
Date:   Tue, 14 Jul 2020 14:20:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <141fbeaf-8fb6-43fb-56ed-5f8a5a019cc7@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/7/14 13:57, Hannes Reinecke wrote:
> On 7/13/20 5:28 AM, Guoju Fang wrote:
>> When read cache miss, backing device will be read first, and then refill
>> the cache device. But under some scenarios there are large number of new
>> reads and rarely hit, so it's necessary to disable the refill when read
>> miss to save space for writes.
>>
>> This patch add a new config called refill_on_miss_disabled which is
>> not set
>> by default. Bcache user can set it by sysfs interface and then the bcache
>> device will not refill when read cache miss.
>>
>> Signed-off-by: Guoju Fang <fangguoju@gmail.com>
>> ---
>>   drivers/md/bcache/bcache.h  | 1 +
>>   drivers/md/bcache/request.c | 2 ++
>>   drivers/md/bcache/super.c   | 1 +
>>   drivers/md/bcache/sysfs.c   | 5 +++++
>>   4 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
>> index 221e0191b687..3a19ee6de3a7 100644
>> --- a/drivers/md/bcache/bcache.h
>> +++ b/drivers/md/bcache/bcache.h
>> @@ -730,6 +730,7 @@ struct cache_set {
>>       unsigned int        shrinker_disabled:1;
>>       unsigned int        copy_gc_enabled:1;
>>       unsigned int        idle_max_writeback_rate_enabled:1;
>> +    unsigned int        refill_on_miss_disabled:1;
>>     #define BUCKET_HASH_BITS    12
>>       struct hlist_head    bucket_hash[1 << BUCKET_HASH_BITS];
>> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
>> index 7acf024e99f3..4bfa0e0b4b3f 100644
>> --- a/drivers/md/bcache/request.c
>> +++ b/drivers/md/bcache/request.c
>> @@ -378,6 +378,8 @@ static bool check_should_bypass(struct cached_dev
>> *dc, struct bio *bio)
>>            op_is_write(bio_op(bio))))
>>           goto skip;
>>   +    if (c->refill_on_miss_disabled && !op_is_write(bio_op(bio)))
>> +        goto skip;
>>       /*
>>        * If the bio is for read-ahead or background IO, bypass it or
>>        * not depends on the following situations,
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index 2014016f9a60..c1e9bfec1267 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -1862,6 +1862,7 @@ struct cache_set *bch_cache_set_alloc(struct
>> cache_sb *sb)
>>       c->congested_write_threshold_us    = 20000;
>>       c->error_limit    = DEFAULT_IO_ERROR_LIMIT;
>>       c->idle_max_writeback_rate_enabled = 1;
>> +    c->refill_on_miss_disabled = 0;
>>       WARN_ON(test_and_clear_bit(CACHE_SET_IO_DISABLE, &c->flags));
>>         return c;
>> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
>> index 0dadec5a78f6..178300f401bb 100644
>> --- a/drivers/md/bcache/sysfs.c
>> +++ b/drivers/md/bcache/sysfs.c
>> @@ -144,6 +144,7 @@ rw_attribute(copy_gc_enabled);
>>   rw_attribute(idle_max_writeback_rate);
>>   rw_attribute(gc_after_writeback);
>>   rw_attribute(size);
>> +rw_attribute(refill_on_miss_disabled);
>>     static ssize_t bch_snprint_string_list(char *buf,
>>                          size_t size,
>> @@ -779,6 +780,8 @@ SHOW(__bch_cache_set)
>>       if (attr == &sysfs_bset_tree_stats)
>>           return bch_bset_print_stats(c, buf);
>>   +    sysfs_printf(refill_on_miss_disabled, "%i",
>> c->refill_on_miss_disabled);
>> +
>>       return 0;
>>   }
>>   SHOW_LOCKED(bch_cache_set)
>> @@ -898,6 +901,7 @@ STORE(__bch_cache_set)
>>        * set in next chance.
>>        */
>>       sysfs_strtoul_clamp(gc_after_writeback, c->gc_after_writeback,
>> 0, 1);
>> +    sysfs_strtoul(refill_on_miss_disabled, c->refill_on_miss_disabled);
>>         return size;
>>   }
>> @@ -948,6 +952,7 @@ static struct attribute *bch_cache_set_files[] = {
>>       &sysfs_congested_read_threshold_us,
>>       &sysfs_congested_write_threshold_us,
>>       &sysfs_clear_stats,
>> +    &sysfs_refill_on_miss_disabled,
>>       NULL
>>   };
>>   KTYPE(bch_cache_set);
>>

Hi Hannes,

> Please don't call the attribute refill_on_miss_disabled.
> This kind of double-negation will always lead to issues; please invert
> the meaning and call it 'refill_on_miss'.

The original purpose is to implement a "write-only" or "read-around"
like cache. Such kind of cache model is desired for heavy write
condition, and disable the read-miss-refill may also help to extend the
SSD life time.

Naming is a challenge here. Becuase "write-only" is not true while read
hitting on dirty data on cache device may successfully return, and
"read-around" is also not true due to the same reason.

We do need help for people to suggest a proper mode for such cache mode,
or cache configuration (if we don't want one more cache mode).

Thanks.

Coly Li
