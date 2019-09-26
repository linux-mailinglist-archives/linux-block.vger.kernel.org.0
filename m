Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5FBF618
	for <lists+linux-block@lfdr.de>; Thu, 26 Sep 2019 17:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfIZPmu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Sep 2019 11:42:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47009 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfIZPmu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 11:42:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so3005907wrv.13
        for <linux-block@vger.kernel.org>; Thu, 26 Sep 2019 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpwR5OQB+xY3WIuqEisZKwNt0UQoj8JXmNFXuSMJCwE=;
        b=a/hAnKXS+9HDKuYBXiN1sVD4g4PquoPFi8ebytrUwHR8OJMwuZRMeQI25EdVSSFe9A
         SVGe2DOCg6OXIcYs7fPjBuk60lwOWeOZHIUYqG4uM8uaT9hk3rVcVRvO9sZMTzIo+KGk
         F1wYVu+9TREFKB2WOafva31ThLdwFRYDWrmB1AhO4N8hkM9B1Daog+LCHkWGP5O3SPhV
         qjEsmAcDfMp/PogyNldplHRPHRCWsvA11I6VZO0tNq6ys7mnoclHtLhE4dr3GK2Sa8mH
         Eb1qGxOs4wBUuEohF5lkro8Ja5JF+qIoMiSiz+QcH/xzqYVh0FIjXADByAH7yj36HisR
         uUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpwR5OQB+xY3WIuqEisZKwNt0UQoj8JXmNFXuSMJCwE=;
        b=KMMxIieoMSKUNAR+mkOHWy/nw4wb9b4OyppFi9arYtNxWAbMbtDuAKPm7ny+TS5hrW
         G9IhHCU9cGHyiPLrqGRnqAEZ0tvL2aMliJ7vWml+1bj3bHSk1QLYmNmaaiobqYRmnNV1
         FYadKndN5qWEMtJeL0kUJvsurGrBwpwkbCmfUyjHDwZNjbSBJBHacMNOhc8043L8BHox
         hsh4H/chW3gfIMecHTMPgv/oelau7GXOdzk95BWqnw1I56aoM9sSllKFcQJIR5muzpS6
         U5Ti79dmxqOUuoIUdQskoYuyMwdgZPoXmcsiXHl5bPbopTPPGuOyeWK6rKisj0XwJULt
         U4jg==
X-Gm-Message-State: APjAAAV+teTFhX2bieNXRxwyUpQ1Z8iQYXkkPlLExoLft0kbVK0hdvE/
        1rQCqjS4LlI0vnK9sLRZo3XeV2iqzTI+WLcQbO7xUQ==
X-Google-Smtp-Source: APXvYqy0nPzyGNaJknLG1OMjqhZXNCiRKAKzkH96nghdpSnxJUn80IzRIGN4BTWgrBrAo7mL/czNLCFCX7zGEqpW0FM=
X-Received: by 2002:a5d:6785:: with SMTP id v5mr3833859wru.9.1569512568417;
 Thu, 26 Sep 2019 08:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-22-jinpuwang@gmail.com>
 <d1208649-5c25-578f-967e-f7a3c9edd9ce@acm.org> <CAMGffE=RpTjDX-LL2E5t_eOF8iwG=UpgWFcnB3tz-N-PQ0etoQ@mail.gmail.com>
 <ab90033d-6045-fcdf-f238-80d8b4852559@acm.org> <CAHg0HuwJJ3LmUwOOw2Uba0Zq_c9hwUyFBrao2nzpv4y97U1Mvg@mail.gmail.com>
 <40f69402-5f38-c78b-8922-3a77babb4c6c@acm.org> <CAHg0HuxOP7Vhkd3pHi8XZBo2uCBGmMOMgSpBQuPTVY9MLB5EBA@mail.gmail.com>
In-Reply-To: <CAHg0HuxOP7Vhkd3pHi8XZBo2uCBGmMOMgSpBQuPTVY9MLB5EBA@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 17:42:37 +0200
Message-ID: <CAMGffE=wV7P3zjZADwD7w_+7QR1QGL=ZoBqCng-r=mjXUD41Cg@mail.gmail.com>
Subject: Re: [PATCH v4 21/25] ibnbd: server: functionality for IO submission
 to file or block dev
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 26, 2019 at 5:38 PM Danil Kipnis
<danil.kipnis@cloud.ionos.com> wrote:
>
> > > Bart, would it in your opinion be OK to drop the file_io support in
> > > IBNBD entirely? We implemented this feature in the beginning of the
> > > project to see whether it could be beneficial in some use cases, but
> > > never actually found any.
> >
> > I think that's reasonable since the loop driver can be used to convert a
> > file into a block device.
> Jack, shall we drop it?

Yes, we should drop it in next round.
