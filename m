Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE89C60C
	for <lists+linux-block@lfdr.de>; Sun, 25 Aug 2019 22:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfHYUJA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 25 Aug 2019 16:09:00 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:56994 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfHYUI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Aug 2019 16:08:59 -0400
Received: from mx02.mta.xmission.com ([166.70.13.212])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1i1yor-0001nP-1f; Sun, 25 Aug 2019 14:08:57 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1i1yoq-0002Lh-5U; Sun, 25 Aug 2019 14:08:56 -0600
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id D50DF72B61;
        Sun, 25 Aug 2019 20:08:54 +0000 (UTC)
Date:   Sun, 25 Aug 2019 16:08:46 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        zub@linux.fjfi.cvut.cz
Message-ID: <20190825200846.GA30738@hacktheplanet>
References: <20190821191051.3535-1-revanth.rajashekar@intel.com>
 <20190821191051.3535-4-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821191051.3535-4-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1i1yoq-0002Lh-5U;;;mid=<20190825200846.GA30738@hacktheplanet>;;;hst=mx02.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_UncommonTLD01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3910]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_UncommonTLD01 Less-common TLD
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Revanth Rajashekar <revanth.rajashekar@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 688 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.2 (0.3%), b_tie_ro: 1.62 (0.2%), parse: 0.77
        (0.1%), extract_message_metadata: 3.3 (0.5%), get_uri_detail_list:
        1.41 (0.2%), tests_pri_-1000: 2.1 (0.3%), tests_pri_-950: 1.21 (0.2%),
        tests_pri_-900: 0.87 (0.1%), tests_pri_-90: 21 (3.0%), check_bayes: 20
        (2.8%), b_tokenize: 6 (0.9%), b_tok_get_all: 7 (1.0%), b_comp_prob:
        1.71 (0.2%), b_tok_touch_all: 3.0 (0.4%), b_finish: 0.56 (0.1%),
        tests_pri_0: 648 (94.2%), check_dkim_signature: 0.67 (0.1%),
        check_dkim_adsp: 314 (45.6%), poll_dns_idle: 305 (44.4%),
        tests_pri_10: 1.76 (0.3%), tests_pri_500: 4.8 (0.7%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 3/3] block: sed-opal: Add support to read/write opal
 tables generically
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx02.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 21, 2019 at 01:10:51PM -0600, Revanth Rajashekar wrote:

[snip]

> The ioctl provides a private field with the intentiont to accommodate
> any future expansions to the ioctl.

spelling (intentiont) 

[snip]

> + * IO_BUFFER_LENGTH = 2048
> + * sizeof(header) = 56
> + * No. of Token Bytes in the Response = 11
> + * MAX size of data that can be carried in response buffer
> + * at a time is : 2048 - (56 + 11) = 1981 = 0x7BD.
> + */
> +#define OPAL_MAX_READ_TABLE (0x7BD)
> +
> +static int read_table_data(struct opal_dev *dev, void *data)
> +{
> +		dst = (u8 __user *)(uintptr_t)read_tbl->data;
> +		if (copy_to_user(dst + off, dev->prev_data, dev->prev_d_len)) {
> +			pr_debug("Error copying data to userspace\n");
> +			err = -EFAULT;
> +			break;
> +		}

I'm with Jon on this one. Even though the spec says we have a max size, lets not put our trust in firmware engineers.
A simple if check is easy to place before the CTU and will solve any future wtf debugging on a userland program.





> +static int opal_generic_read_write_table(struct opal_dev *dev,
> +                                         struct opal_read_write_table *rw_tbl)
> +{
> +	const struct opal_step write_table_steps[] = {
> +		{ start_admin1LSP_opal_session, &rw_tbl->key },
> +		{ write_table_data, rw_tbl },
> +		{ end_opal_session, }
> +	};
> +
> +	const struct opal_step read_table_steps[] = {
> +		{ start_admin1LSP_opal_session, &rw_tbl->key },
> +		{ read_table_data, rw_tbl },
> +		{ end_opal_session, }
> +	};
> +	int ret = 0;
> +
> +	mutex_lock(&dev->dev_lock);
> +	setup_opal_dev(dev);
> +	if (rw_tbl->flags & OPAL_TABLE_READ) {
> +		if (rw_tbl->size > 0)
> +			ret = execute_steps(dev, read_table_steps,
> +					    ARRAY_SIZE(read_table_steps));
> +	} else if (rw_tbl->flags & OPAL_TABLE_WRITE) {
> +		if (rw_tbl->size > 0)
> +			ret = execute_steps(dev, write_table_steps,
> +					    ARRAY_SIZE(write_table_steps));
> +	} else {
> +		pr_debug("Invalid bit set in the flag.\n");
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&dev->dev_lock);
> +
> +	return ret;
> +}

Do we expect to add more flags in the future? I ask because this function can quickly get out
of hand with regard to the else if chain and the function table list above. If we think we're going
to add more flags in the future lets slap a switch statement in here to call opal_table_write() and
opal_table_read(). We can deal with that in the future I guess, I just don't want a 3000 line function.




> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index 59eed0bdffd3..a803ed0534da 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> +struct opal_read_write_table {
> +	struct opal_key key;
> +	const __u64 data;
> +	const __u8 table_uid[OPAL_UID_LENGTH];
> +	__u64 offset;
> +	__u64 size;
> +	#define OPAL_TABLE_READ (1 << 0)
> +	#define OPAL_TABLE_WRITE (1 << 1)
> +	__u64 flags;
> +	__u64 priv;
> +};

Two things, can you double check the pahole on this struct (Google it or ask Jon he knows).
Second, can you lift those defines into Enumerations or out of the struct? Is there a reason
they're in there?

